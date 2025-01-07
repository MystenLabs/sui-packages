module 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_nft {
    struct SuiPlay0x1PreorderNFT has key {
        id: 0x2::object::UID,
        tier: 0x1::string::String,
        name: 0x1::string::String,
        order: u64,
        datetime: u64,
        payment_chain: 0x1::string::String,
        payment_tx_digest: 0x1::string::String,
    }

    struct TransferWhitelist has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<address, address>,
    }

    struct TransferWhitelistAuthorizedCaps has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_authorized_whitelist_manager(arg0: &0x2::package::Publisher, arg1: &mut TransferWhitelist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<SuiPlay0x1PreorderNFT>(arg0), 6);
        let v0 = TransferWhitelistAuthorizedCaps{dummy_field: false};
        0x2::dynamic_field::add<TransferWhitelistAuthorizedCaps, address>(&mut arg1.id, v0, arg2);
    }

    public fun add_nft_to_whitelist(arg0: &mut TransferWhitelist, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_whitelist_manager(arg0, 0x2::tx_context::sender(arg3)), 8);
        0x2::table::add<address, address>(&mut arg0.entries, 0x2::object::id_to_address(&arg1), arg2);
    }

    public fun convert_exalted_to_mythic(arg0: &mut 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::SuiPlayPreorderRegistry, arg1: &mut SuiPlay0x1PreorderNFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.tier == 0x1::string::utf8(0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants::tier_exalted_name()) && arg1.order <= 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants::max_mythics_units(), 5);
        arg1.tier = 0x1::string::utf8(0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants::tier_mythics_name());
        0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::sync_minted_counters(arg0);
    }

    public fun is_authorized_whitelist_manager(arg0: &TransferWhitelist, arg1: address) : bool {
        let v0 = TransferWhitelistAuthorizedCaps{dummy_field: false};
        0x2::dynamic_field::borrow<TransferWhitelistAuthorizedCaps, address>(&arg0.id, v0) == &arg1
    }

    public fun mint(arg0: &0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::SuiPlayMintCap, arg1: &mut 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::SuiPlayPreorderRegistry, arg2: 0x1::string::String, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::mintcap_version(arg0) == 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::config_version(arg1), 3);
        let v0 = 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants::supported_chains();
        assert!(0x1::vector::contains<vector<u8>>(&v0, 0x1::string::as_bytes(&arg4)), 2);
        assert!(0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::can_mint(arg1), 1);
        0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::update_minted(arg1);
        let v1 = SuiPlay0x1PreorderNFT{
            id                : 0x2::object::new(arg7),
            tier              : 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::current_tier_name(arg1),
            name              : arg2,
            order             : 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::total_mints(arg1),
            datetime          : 0x2::clock::timestamp_ms(arg6),
            payment_chain     : arg4,
            payment_tx_digest : arg5,
        };
        0x2::transfer::transfer<SuiPlay0x1PreorderNFT>(v1, arg3);
        if (0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::current_tier_key(arg1) == 1 && 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::mythics_minted(arg1) == 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::current_tier_max_supply(arg1)) {
            0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::bump_tier(arg1);
        };
    }

    public fun mint_by_auth(arg0: &mut 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::SuiPlayPreorderRegistry, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::is_authorized_minter(arg0, 0x2::tx_context::sender(arg6)), 4);
        let v0 = 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants::supported_chains();
        assert!(0x1::vector::contains<vector<u8>>(&v0, 0x1::string::as_bytes(&arg3)), 2);
        assert!(0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::can_mint(arg0), 1);
        0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::update_minted(arg0);
        let v1 = SuiPlay0x1PreorderNFT{
            id                : 0x2::object::new(arg6),
            tier              : 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::current_tier_name(arg0),
            name              : arg1,
            order             : 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::total_mints(arg0),
            datetime          : 0x2::clock::timestamp_ms(arg5),
            payment_chain     : arg3,
            payment_tx_digest : arg4,
        };
        0x2::transfer::transfer<SuiPlay0x1PreorderNFT>(v1, arg2);
        if (0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::current_tier_key(arg0) == 1 && 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::mythics_minted(arg0) == 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::current_tier_max_supply(arg0)) {
            0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder::bump_tier(arg0);
        };
    }

    public fun new_whitelist(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<TransferWhitelist>(arg0), 6);
        let v0 = TransferWhitelist{
            id      : 0x2::object::new(arg1),
            entries : 0x2::table::new<address, address>(arg1),
        };
        0x2::transfer::share_object<TransferWhitelist>(v0);
    }

    public fun order(arg0: &SuiPlay0x1PreorderNFT) : u64 {
        arg0.order
    }

    public fun remove_nft_from_whitelist(arg0: &mut TransferWhitelist, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_whitelist_manager(arg0, 0x2::tx_context::sender(arg2)), 8);
        0x2::table::remove<address, address>(&mut arg0.entries, 0x2::object::id_to_address(&arg1));
    }

    public fun reset_authorized_whitelist_manager(arg0: &0x2::package::Publisher, arg1: &mut TransferWhitelist, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<SuiPlay0x1PreorderNFT>(arg0), 6);
        let v0 = TransferWhitelistAuthorizedCaps{dummy_field: false};
        0x2::dynamic_field::remove<TransferWhitelistAuthorizedCaps, address>(&mut arg1.id, v0);
    }

    public fun tier(arg0: &SuiPlay0x1PreorderNFT) : &0x1::string::String {
        &arg0.tier
    }

    public fun transfer_to_whitelist_manager(arg0: SuiPlay0x1PreorderNFT, arg1: &mut TransferWhitelist, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, address>(&arg1.entries, 0x2::object::uid_to_address(&arg0.id)), 7);
        let v0 = 0x2::object::id<SuiPlay0x1PreorderNFT>(&arg0);
        0x2::table::remove<address, address>(&mut arg1.entries, 0x2::object::id_to_address(&v0));
        let v1 = TransferWhitelistAuthorizedCaps{dummy_field: false};
        0x2::transfer::transfer<SuiPlay0x1PreorderNFT>(arg0, *0x2::dynamic_field::borrow<TransferWhitelistAuthorizedCaps, address>(&arg1.id, v1));
    }

    public fun whitelist_entries(arg0: &TransferWhitelist) : &0x2::table::Table<address, address> {
        &arg0.entries
    }

    // decompiled from Move bytecode v6
}

