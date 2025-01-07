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

    // decompiled from Move bytecode v6
}

