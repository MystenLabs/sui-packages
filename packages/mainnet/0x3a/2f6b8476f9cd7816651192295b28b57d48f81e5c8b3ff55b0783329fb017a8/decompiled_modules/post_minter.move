module 0x3a2f6b8476f9cd7816651192295b28b57d48f81e5c8b3ff55b0783329fb017a8::post_minter {
    struct Post has key {
        id: 0x2::object::UID,
        creator_handle: 0x1::string::String,
        creator_address: address,
        post_type: u8,
        content: 0x1::option::Option<0x1::string::String>,
        media_urls: 0x1::option::Option<vector<0x2::url::Url>>,
        reference_id: 0x1::option::Option<0x1::string::String>,
        name: 0x1::string::String,
        royalty_fee_percentage: u64,
        price_in_usd_cents: u64,
        quantity: 0x1::option::Option<u64>,
        created_at_epoch: u64,
        created_at_ms: u64,
    }

    struct SocialMediaPlatform has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        limited_quantities: vector<0x2::object::ID>,
        activated: bool,
        paused: bool,
        admin_wallet: address,
        company_wallet: address,
        company_second_wallet_for_verification: address,
        pending_wallet_update: 0x1::option::Option<address>,
        pending_wallet_verification: bool,
        pending_admin_transfer: 0x1::option::Option<PendingAdminTransfer>,
        pending_admin_transfer_verification: bool,
    }

    struct PostMinted has copy, drop {
        post_id: 0x2::object::ID,
        creator_handle: 0x1::string::String,
        post_type: u8,
        royalty_fee_percentage: u64,
        price_in_usd_cents: u64,
        reference_id: 0x1::option::Option<0x1::string::String>,
    }

    struct PostTransferred has copy, drop {
        post_id: 0x2::object::ID,
        to: address,
        reference_id: 0x1::option::Option<0x1::string::String>,
    }

    struct PostBurned has copy, drop {
        post_id: 0x2::object::ID,
        owner: address,
        post_type: u8,
        reference_id: 0x1::option::Option<0x1::string::String>,
    }

    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    struct WalletUpdated has copy, drop {
        old_wallet: address,
        new_wallet: address,
        update_time: u64,
    }

    struct PendingAdminTransfer has drop, store {
        new_admin: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
        transfer_time: u64,
    }

    struct POST_MINTER has drop {
        dummy_field: bool,
    }

    public entry fun activate_platform(arg0: &AdminCapability, arg1: address, arg2: address, arg3: &mut SocialMediaPlatform, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.activated, 10);
        assert!(arg1 != arg2, 0);
        arg3.company_wallet = arg1;
        arg3.company_second_wallet_for_verification = arg2;
        arg3.activated = true;
    }

    fun burn_post_internal(arg0: &mut SocialMediaPlatform, arg1: Post, arg2: address) {
        assert!(!arg0.paused, 8);
        assert!(arg0.activated, 9);
        let v0 = 0x2::object::id<Post>(&arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.limited_quantities, &v0);
        assert!(v1, 3);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.limited_quantities, v2);
        let v3 = PostBurned{
            post_id      : v0,
            owner        : arg2,
            post_type    : arg1.post_type,
            reference_id : arg1.reference_id,
        };
        0x2::event::emit<PostBurned>(v3);
        let Post {
            id                     : v4,
            creator_handle         : _,
            creator_address        : _,
            post_type              : _,
            content                : _,
            media_urls             : _,
            reference_id           : _,
            name                   : _,
            royalty_fee_percentage : _,
            price_in_usd_cents     : _,
            quantity               : _,
            created_at_epoch       : _,
            created_at_ms          : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    public entry fun burn_post_without_fee(arg0: &AdminCapability, arg1: &mut SocialMediaPlatform, arg2: Post, arg3: address) {
        burn_post_internal(arg1, arg2, arg3);
    }

    public entry fun complete_admin_transfer(arg0: &AdminCapability, arg1: &mut SocialMediaPlatform, arg2: AdminCapability, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.activated, 9);
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg1.pending_admin_transfer), 14);
        assert!(arg1.pending_admin_transfer_verification, 14);
        let v0 = 0x1::option::extract<PendingAdminTransfer>(&mut arg1.pending_admin_transfer);
        arg1.admin_wallet = v0.new_admin;
        0x2::transfer::transfer<AdminCapability>(arg2, v0.new_admin);
        let v1 = AdminTransferred{
            old_admin     : 0x2::tx_context::sender(arg3),
            new_admin     : v0.new_admin,
            transfer_time : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<AdminTransferred>(v1);
        arg1.pending_admin_transfer = 0x1::option::none<PendingAdminTransfer>();
        arg1.pending_admin_transfer_verification = false;
    }

    public entry fun complete_wallet_update_by_company_second_wallet(arg0: &mut SocialMediaPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.activated, 9);
        assert!(0x1::option::is_some<address>(&arg0.pending_wallet_update), 0);
        assert!(arg0.pending_wallet_verification, 0);
        assert!(0x2::tx_context::sender(arg1) == arg0.company_second_wallet_for_verification, 0);
        let v0 = 0x1::option::extract<address>(&mut arg0.pending_wallet_update);
        arg0.company_wallet = v0;
        arg0.pending_wallet_update = 0x1::option::none<address>();
        arg0.pending_wallet_verification = false;
        let v1 = WalletUpdated{
            old_wallet  : arg0.company_wallet,
            new_wallet  : v0,
            update_time : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<WalletUpdated>(v1);
    }

    fun init(arg0: POST_MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SocialMediaPlatform{
            id                                     : 0x2::object::new(arg1),
            name                                   : 0x1::string::utf8(b"Moseiki"),
            limited_quantities                     : 0x1::vector::empty<0x2::object::ID>(),
            activated                              : false,
            paused                                 : false,
            admin_wallet                           : v0,
            company_wallet                         : v0,
            company_second_wallet_for_verification : v0,
            pending_wallet_update                  : 0x1::option::none<address>(),
            pending_wallet_verification            : false,
            pending_admin_transfer                 : 0x1::option::none<PendingAdminTransfer>(),
            pending_admin_transfer_verification    : false,
        };
        let v2 = AdminCapability{id: 0x2::object::new(arg1)};
        let v3 = 0x2::package::claim<POST_MINTER>(arg0, arg1);
        let v4 = 0x2::display::new<Post>(&v3, arg1);
        0x2::display::add<Post>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Moseiki App Post"));
        0x2::display::add<Post>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://moseiki.app/_next/image?url=%2Flogo.svg&w=118&q=75"));
        0x2::display::add<Post>(&mut v4, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://moseiki.app"));
        0x2::display::add<Post>(&mut v4, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Moseiki App"));
        0x2::display::add<Post>(&mut v4, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://moseiki.app/?loginRedirect=/post?search={id}"));
        0x2::display::update_version<Post>(&mut v4);
        0x2::transfer::transfer<AdminCapability>(v2, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Post>>(v4, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::share_object<SocialMediaPlatform>(v1);
    }

    public entry fun initiate_admin_transfer(arg0: &mut SocialMediaPlatform, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.activated, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.company_wallet, 4);
        assert!(arg1 != v0, 15);
        assert!(arg1 != arg0.company_second_wallet_for_verification, 15);
        let v1 = PendingAdminTransfer{new_admin: arg1};
        arg0.pending_admin_transfer = 0x1::option::some<PendingAdminTransfer>(v1);
        arg0.pending_admin_transfer_verification = false;
    }

    public entry fun initiate_wallet_update_by_admin(arg0: &AdminCapability, arg1: &mut SocialMediaPlatform, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.activated, 9);
        assert!(arg2 != 0x2::tx_context::sender(arg3), 0);
        assert!(arg2 != arg1.company_second_wallet_for_verification, 0);
        arg1.pending_wallet_update = 0x1::option::some<address>(arg2);
        arg1.pending_wallet_verification = false;
    }

    public entry fun interim_transfer_post_to_admin(arg0: &mut SocialMediaPlatform, arg1: Post, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Post>(arg1, arg0.admin_wallet);
        let v0 = PostTransferred{
            post_id      : 0x2::object::id<Post>(&arg1),
            to           : arg0.admin_wallet,
            reference_id : arg1.reference_id,
        };
        0x2::event::emit<PostTransferred>(v0);
    }

    fun mint_post_internal(arg0: &mut SocialMediaPlatform, arg1: vector<u8>, arg2: address, arg3: u8, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        assert!(arg0.activated, 9);
        assert!(0x1::vector::length<u8>(&arg4) <= 10000, 7);
        assert!(arg7 >= 0 && arg7 <= 100, 16);
        let v0 = if (arg3 == 10) {
            true
        } else if (arg3 == 20) {
            true
        } else if (arg3 == 30) {
            true
        } else if (arg3 == 40) {
            true
        } else {
            arg3 == 50
        };
        assert!(v0, 0);
        let v1 = if (0x1::vector::is_empty<u8>(&arg10)) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg10))
        };
        let v2 = if (0x1::vector::is_empty<vector<u8>>(&arg5)) {
            0x1::option::none<vector<0x2::url::Url>>()
        } else {
            let v3 = 0x1::vector::empty<0x2::url::Url>();
            let v4 = 0;
            while (v4 < 0x1::vector::length<vector<u8>>(&arg5)) {
                0x1::vector::push_back<0x2::url::Url>(&mut v3, 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg5, v4)));
                v4 = v4 + 1;
            };
            0x1::option::some<vector<0x2::url::Url>>(v3)
        };
        let v5 = if (0x1::vector::is_empty<u8>(&arg4)) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg4))
        };
        let v6 = Post{
            id                     : 0x2::object::new(arg12),
            creator_handle         : 0x1::string::utf8(arg1),
            creator_address        : arg2,
            post_type              : arg3,
            content                : v5,
            media_urls             : v2,
            reference_id           : v1,
            name                   : 0x1::string::utf8(arg6),
            royalty_fee_percentage : arg7,
            price_in_usd_cents     : arg8,
            quantity               : 0x1::option::some<u64>(arg9),
            created_at_epoch       : 0x2::tx_context::epoch(arg12),
            created_at_ms          : 0x2::clock::timestamp_ms(arg11),
        };
        let v7 = 0x2::object::id<Post>(&v6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.limited_quantities, v7);
        0x2::transfer::transfer<Post>(v6, arg2);
        let v8 = PostMinted{
            post_id                : v7,
            creator_handle         : 0x1::string::utf8(arg1),
            post_type              : arg3,
            royalty_fee_percentage : arg7,
            price_in_usd_cents     : arg8,
            reference_id           : v1,
        };
        0x2::event::emit<PostMinted>(v8);
    }

    public entry fun mint_post_without_fee(arg0: &AdminCapability, arg1: &mut SocialMediaPlatform, arg2: vector<u8>, arg3: address, arg4: u8, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        mint_post_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun pause_service(arg0: &AdminCapability, arg1: &mut SocialMediaPlatform) {
        arg1.paused = true;
    }

    public entry fun transfer_post_without_fee(arg0: &AdminCapability, arg1: Post, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Post>(arg1, arg2);
        let v0 = PostTransferred{
            post_id      : 0x2::object::id<Post>(&arg1),
            to           : arg2,
            reference_id : arg1.reference_id,
        };
        0x2::event::emit<PostTransferred>(v0);
    }

    public entry fun unpause_service(arg0: &AdminCapability, arg1: &mut SocialMediaPlatform) {
        arg1.paused = false;
    }

    public entry fun update_company_wallet(arg0: &AdminCapability, arg1: &mut SocialMediaPlatform, arg2: address) {
        arg1.company_wallet = arg2;
    }

    public entry fun update_post_price(arg0: &mut SocialMediaPlatform, arg1: &mut Post, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        assert!(arg0.activated, 9);
        arg1.price_in_usd_cents = arg2;
    }

    public entry fun verify_admin_transfer(arg0: &mut SocialMediaPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.activated, 9);
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_admin_transfer), 14);
        assert!(0x2::tx_context::sender(arg1) == arg0.company_second_wallet_for_verification, 4);
        arg0.pending_admin_transfer_verification = true;
    }

    public entry fun verify_wallet_update_by_company_wallet(arg0: &mut SocialMediaPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.activated, 9);
        assert!(0x1::option::is_some<address>(&arg0.pending_wallet_update), 0);
        assert!(0x2::tx_context::sender(arg1) == arg0.company_wallet, 0);
        arg0.pending_wallet_verification = true;
    }

    // decompiled from Move bytecode v6
}

