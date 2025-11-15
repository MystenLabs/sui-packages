module 0x41a661459697449b2716a697266e181ca4e359050eeeec791760f31af179b82a::membership {
    struct MEMBERSHIP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MemberRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_members: u64,
        total_revenue_collected: u64,
        active_image_url: 0x1::string::String,
        expired_image_url: 0x1::string::String,
    }

    struct MembershipNFT has store, key {
        id: 0x2::object::UID,
        owner: address,
        member_number: u64,
        issued_at: u64,
        expires_at: u64,
        streams_used: u64,
        total_watch_time: u64,
        image_url: 0x1::string::String,
        is_transferable: bool,
    }

    struct MembershipMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        member_number: u64,
        expires_at: u64,
    }

    struct MembershipRenewed has copy, drop {
        nft_id: 0x2::object::ID,
        new_expiry: u64,
    }

    struct DisplayUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        new_image_url: 0x1::string::String,
        is_expired: bool,
    }

    fun init(arg0: MEMBERSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = MemberRegistry{
            id                      : 0x2::object::new(arg1),
            admin                   : 0x2::tx_context::sender(arg1),
            total_members           : 0,
            total_revenue_collected : 0,
            active_image_url        : 0x1::string::utf8(b"https://blockbuster.streaming/nft/active-card.png"),
            expired_image_url       : 0x1::string::utf8(b"https://blockbuster.streaming/nft/expired-card.png"),
        };
        let v2 = 0x2::package::claim<MEMBERSHIP>(arg0, arg1);
        let v3 = 0x2::display::new<MembershipNFT>(&v2, arg1);
        0x2::display::add<MembershipNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Blockbuster Membership Card #{member_number}"));
        0x2::display::add<MembershipNFT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Official Blockbuster membership card. Unlimited streaming access. 70% to creators."));
        0x2::display::add<MembershipNFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<MembershipNFT>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://blockbuster.streaming"));
        0x2::display::add<MembershipNFT>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Blockbuster"));
        0x2::display::update_version<MembershipNFT>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MembershipNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MemberRegistry>(v1);
    }

    public fun is_active(arg0: &MembershipNFT, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.expires_at > 0x2::tx_context::epoch_timestamp_ms(arg1)
    }

    public entry fun mint_membership(arg0: &mut MemberRegistry, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 2500000000, 1);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v1 = v0 + arg1 * 86400 * 1000;
        arg0.total_members = arg0.total_members + 1;
        let v2 = arg0.total_members;
        let v3 = 0x2::object::new(arg3);
        let v4 = MembershipNFT{
            id               : v3,
            owner            : 0x2::tx_context::sender(arg3),
            member_number    : v2,
            issued_at        : v0,
            expires_at       : v1,
            streams_used     : 0,
            total_watch_time : 0,
            image_url        : arg0.active_image_url,
            is_transferable  : true,
        };
        arg0.total_revenue_collected = arg0.total_revenue_collected + 2500000000;
        let v5 = MembershipMinted{
            nft_id        : 0x2::object::uid_to_inner(&v3),
            owner         : 0x2::tx_context::sender(arg3),
            member_number : v2,
            expires_at    : v1,
        };
        0x2::event::emit<MembershipMinted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.admin);
        0x2::transfer::transfer<MembershipNFT>(v4, 0x2::tx_context::sender(arg3));
    }

    public entry fun record_stream_usage(arg0: &mut MembershipNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.streams_used = arg0.streams_used + 1;
        arg0.total_watch_time = arg0.total_watch_time + arg1;
    }

    public entry fun renew_membership(arg0: &mut MembershipNFT, arg1: &mut MemberRegistry, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 2500000000, 1);
        arg0.expires_at = arg0.expires_at + arg2 * 86400 * 1000;
        arg0.image_url = arg1.active_image_url;
        arg1.total_revenue_collected = arg1.total_revenue_collected + 2500000000;
        let v0 = MembershipRenewed{
            nft_id     : 0x2::object::uid_to_inner(&arg0.id),
            new_expiry : arg0.expires_at,
        };
        0x2::event::emit<MembershipRenewed>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1.admin);
    }

    public entry fun update_image_urls(arg0: &AdminCap, arg1: &mut MemberRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.active_image_url = arg2;
        arg1.expired_image_url = arg3;
    }

    public entry fun update_nft_display(arg0: &mut MembershipNFT, arg1: &MemberRegistry, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2) >= arg0.expires_at;
        if (v0) {
            arg0.image_url = arg1.expired_image_url;
        } else {
            arg0.image_url = arg1.active_image_url;
        };
        let v1 = DisplayUpdated{
            nft_id        : 0x2::object::uid_to_inner(&arg0.id),
            new_image_url : arg0.image_url,
            is_expired    : v0,
        };
        0x2::event::emit<DisplayUpdated>(v1);
    }

    public entry fun update_transferability(arg0: &AdminCap, arg1: &mut MembershipNFT, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_transferable = arg2;
    }

    // decompiled from Move bytecode v6
}

