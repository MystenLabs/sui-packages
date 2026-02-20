module 0xd92c70005795eacd56e0fdd2259090c142a2c1ef2e5a3edb1d277119b504b0f7::sponsorship_nfts {
    struct SPONSORSHIP_NFTS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SponsorshipRegistry has key {
        id: 0x2::object::UID,
        silver_holders: 0x2::table::Table<address, u64>,
        golden_holders: 0x2::table::Table<address, u64>,
        total_silver_minted: u64,
        total_golden_minted: u64,
        total_silver_holders: u64,
        total_golden_holders: u64,
        paused: bool,
    }

    struct SilverSponsorshipNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        minted_at: u64,
        owner: address,
    }

    struct GoldenSponsorshipNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        minted_at: u64,
        owner: address,
    }

    struct SilverSponsorshipNFTMinted has copy, drop {
        nft_id: address,
        recipient: address,
        minted_by: address,
        timestamp: u64,
    }

    struct GoldenSponsorshipNFTMinted has copy, drop {
        nft_id: address,
        recipient: address,
        minted_by: address,
        timestamp: u64,
    }

    public entry fun create_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun get_golden_nft_count(arg0: &SponsorshipRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.golden_holders, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.golden_holders, arg1)
        } else {
            0
        }
    }

    public fun get_silver_nft_count(arg0: &SponsorshipRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.silver_holders, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.silver_holders, arg1)
        } else {
            0
        }
    }

    public fun get_total_golden_holders(arg0: &SponsorshipRegistry) : u64 {
        arg0.total_golden_holders
    }

    public fun get_total_golden_minted(arg0: &SponsorshipRegistry) : u64 {
        arg0.total_golden_minted
    }

    public fun get_total_silver_holders(arg0: &SponsorshipRegistry) : u64 {
        arg0.total_silver_holders
    }

    public fun get_total_silver_minted(arg0: &SponsorshipRegistry) : u64 {
        arg0.total_silver_minted
    }

    fun init(arg0: SPONSORSHIP_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SponsorshipRegistry{
            id                   : 0x2::object::new(arg0),
            silver_holders       : 0x2::table::new<address, u64>(arg0),
            golden_holders       : 0x2::table::new<address, u64>(arg0),
            total_silver_minted  : 0,
            total_golden_minted  : 0,
            total_silver_holders : 0,
            total_golden_holders : 0,
            paused               : false,
        };
        0x2::transfer::share_object<SponsorshipRegistry>(v0);
    }

    public fun is_paused(arg0: &SponsorshipRegistry) : bool {
        arg0.paused
    }

    public entry fun mint_golden(arg0: &AdminCap, arg1: &mut SponsorshipRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v1 = 0x2::object::new(arg3);
        let v2 = GoldenSponsorshipNFT{
            id          : v1,
            name        : 0x1::string::utf8(b"NETSTREAM Golden Sponsorship NFT"),
            description : 0x1::string::utf8(b"NETSTREAM Golden Sponsorship NFT - Free soulbound NFT granted by admin with Golden-tier access"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://netstream.app/nft/sponsorship-golden.png"),
            minted_at   : v0,
            owner       : arg2,
        };
        if (0x2::table::contains<address, u64>(&arg1.golden_holders, arg2)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg1.golden_holders, arg2);
            *v3 = *v3 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.golden_holders, arg2, 1);
            arg1.total_golden_holders = arg1.total_golden_holders + 1;
        };
        arg1.total_golden_minted = arg1.total_golden_minted + 1;
        let v4 = GoldenSponsorshipNFTMinted{
            nft_id    : 0x2::object::uid_to_address(&v1),
            recipient : arg2,
            minted_by : 0x2::tx_context::sender(arg3),
            timestamp : v0,
        };
        0x2::event::emit<GoldenSponsorshipNFTMinted>(v4);
        0x2::transfer::transfer<GoldenSponsorshipNFT>(v2, arg2);
    }

    public entry fun mint_silver(arg0: &AdminCap, arg1: &mut SponsorshipRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v1 = 0x2::object::new(arg3);
        let v2 = SilverSponsorshipNFT{
            id          : v1,
            name        : 0x1::string::utf8(b"NETSTREAM Silver Sponsorship NFT"),
            description : 0x1::string::utf8(b"NETSTREAM Silver Sponsorship NFT - Free soulbound NFT granted by admin with Silver-tier access"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://netstream.app/nft/sponsorship-silver.png"),
            minted_at   : v0,
            owner       : arg2,
        };
        if (0x2::table::contains<address, u64>(&arg1.silver_holders, arg2)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg1.silver_holders, arg2);
            *v3 = *v3 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.silver_holders, arg2, 1);
            arg1.total_silver_holders = arg1.total_silver_holders + 1;
        };
        arg1.total_silver_minted = arg1.total_silver_minted + 1;
        let v4 = SilverSponsorshipNFTMinted{
            nft_id    : 0x2::object::uid_to_address(&v1),
            recipient : arg2,
            minted_by : 0x2::tx_context::sender(arg3),
            timestamp : v0,
        };
        0x2::event::emit<SilverSponsorshipNFTMinted>(v4);
        0x2::transfer::transfer<SilverSponsorshipNFT>(v2, arg2);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut SponsorshipRegistry, arg2: bool) {
        arg1.paused = arg2;
    }

    // decompiled from Move bytecode v6
}

