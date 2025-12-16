module 0xf4c6b10e1417dbe78f42e8e95588626e9b9f0991f1b096c1fb3a0ac8b8cb3820::membership {
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

    public entry fun mint_membership(arg0: &mut MemberRegistry, arg1: u64, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= 2500000000, 1);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = v1 + arg1 * 86400 * 1000;
        arg0.total_members = arg0.total_members + 1;
        let v3 = arg0.total_members;
        let v4 = 0x2::object::new(arg4);
        let v5 = MembershipNFT{
            id               : v4,
            owner            : 0x2::tx_context::sender(arg4),
            member_number    : v3,
            issued_at        : v1,
            expires_at       : v2,
            streams_used     : 0,
            total_watch_time : 0,
            image_url        : arg2,
            is_transferable  : true,
        };
        arg0.total_revenue_collected = arg0.total_revenue_collected + v0;
        let v6 = MembershipMinted{
            nft_id        : 0x2::object::uid_to_inner(&v4),
            owner         : 0x2::tx_context::sender(arg4),
            member_number : v3,
            expires_at    : v2,
        };
        0x2::event::emit<MembershipMinted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.admin);
        0x2::transfer::transfer<MembershipNFT>(v5, 0x2::tx_context::sender(arg4));
    }

    public entry fun record_stream_usage(arg0: &mut MembershipNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.streams_used = arg0.streams_used + 1;
        arg0.total_watch_time = arg0.total_watch_time + arg1;
    }

    public entry fun renew_membership(arg0: &mut MembershipNFT, arg1: &mut MemberRegistry, arg2: u64, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 >= 2500000000, 1);
        arg0.expires_at = arg0.expires_at + arg2 * 86400 * 1000;
        arg0.image_url = arg3;
        arg1.total_revenue_collected = arg1.total_revenue_collected + v0;
        let v1 = MembershipRenewed{
            nft_id     : 0x2::object::uid_to_inner(&arg0.id),
            new_expiry : arg0.expires_at,
        };
        0x2::event::emit<MembershipRenewed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg1.admin);
    }

    public entry fun update_nft_display(arg0: &mut MembershipNFT, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        arg0.image_url = arg1;
        let v0 = DisplayUpdated{
            nft_id        : 0x2::object::uid_to_inner(&arg0.id),
            new_image_url : arg1,
            is_expired    : 0x2::tx_context::epoch_timestamp_ms(arg2) >= arg0.expires_at,
        };
        0x2::event::emit<DisplayUpdated>(v0);
    }

    public entry fun update_transferability(arg0: &AdminCap, arg1: &mut MembershipNFT, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_transferable = arg2;
    }

    // decompiled from Move bytecode v6
}

