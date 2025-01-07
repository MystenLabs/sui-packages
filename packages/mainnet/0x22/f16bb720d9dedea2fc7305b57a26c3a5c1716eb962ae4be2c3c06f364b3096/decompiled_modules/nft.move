module 0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft {
    struct NFTMinted has copy, drop {
        creator: address,
        nft_id: address,
        deposit: u64,
        miners: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct MinerNFT has store, key {
        id: 0x2::object::UID,
        creator: address,
        deposit: u64,
        withdrawn: u64,
        last_hatch: u64,
        hatchery_miners: u64,
        claimed_eggs: u64,
        reinvest_count: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MinerTransferPolicy has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    public fun add_deposit(arg0: &mut MinerNFT, arg1: u64) {
        arg0.deposit = arg0.deposit + arg1;
    }

    public fun add_miners(arg0: &mut MinerNFT, arg1: u64) {
        arg0.hatchery_miners = arg0.hatchery_miners + arg1;
    }

    public fun add_withdrawn(arg0: &mut MinerNFT, arg1: u64) {
        arg0.withdrawn = arg0.withdrawn + arg1;
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun delist_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        assert!(0x2::kiosk::is_listed(arg0, arg2), 5);
        0x2::kiosk::delist<T0>(arg0, arg1, arg2);
    }

    public fun get_claimed_eggs(arg0: &MinerNFT) : u64 {
        arg0.claimed_eggs
    }

    public fun get_creator(arg0: &MinerNFT) : address {
        arg0.creator
    }

    public fun get_current_deposit(arg0: &MinerNFT) : u64 {
        arg0.deposit
    }

    public fun get_current_withdrawn(arg0: &MinerNFT) : u64 {
        arg0.withdrawn
    }

    public fun get_hatchery_miners(arg0: &MinerNFT) : u64 {
        arg0.hatchery_miners
    }

    public fun get_last_hatch(arg0: &MinerNFT) : u64 {
        arg0.last_hatch
    }

    public fun get_reinvest_count(arg0: &MinerNFT) : u64 {
        arg0.reinvest_count
    }

    public fun increment_reinvest_count(arg0: &mut MinerNFT) {
        arg0.reinvest_count = arg0.reinvest_count + 1;
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"deposit"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"miners"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"withdrawn"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{deposit}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{hatchery_miners}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://example.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{withdrawn}"));
        let v5 = 0x2::display::new_with_fields<MinerNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<MinerNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MinerNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun list_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: MinerNFT, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 4);
        0x2::kiosk::place<MinerNFT>(arg0, arg1, arg2);
        0x2::kiosk::list<MinerNFT>(arg0, arg1, 0x2::object::id<MinerNFT>(&arg2), arg3);
    }

    public fun mint_nft(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MinerNFT {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = MinerNFT{
            id              : 0x2::object::new(arg2),
            creator         : v0,
            deposit         : arg0,
            withdrawn       : 0,
            last_hatch      : 0x2::tx_context::epoch_timestamp_ms(arg2),
            hatchery_miners : arg1,
            claimed_eggs    : 0,
            reinvest_count  : 0,
            name            : 0x1::string::utf8(b"Miner NFT"),
            description     : 0x1::string::utf8(b"Your personal miner NFT"),
            url             : 0x2::url::new_unsafe_from_bytes(b"https://example.com/nft.png"),
        };
        let v2 = NFTMinted{
            creator : v0,
            nft_id  : 0x2::object::uid_to_address(&v1.id),
            deposit : arg0,
            miners  : arg1,
        };
        0x2::event::emit<NFTMinted>(v2);
        v1
    }

    public entry fun purchase_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::transfer_policy::TransferPolicy<MinerNFT>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<MinerNFT>(arg0, arg2, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<MinerNFT>(arg1, v1);
        0x2::transfer::public_transfer<MinerNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun reset_claimed_eggs(arg0: &mut MinerNFT) {
        arg0.claimed_eggs = 0;
    }

    public fun set_last_hatch(arg0: &mut MinerNFT, arg1: u64) {
        arg0.last_hatch = arg1;
    }

    public entry fun take_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MinerNFT>(0x2::kiosk::take<MinerNFT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

