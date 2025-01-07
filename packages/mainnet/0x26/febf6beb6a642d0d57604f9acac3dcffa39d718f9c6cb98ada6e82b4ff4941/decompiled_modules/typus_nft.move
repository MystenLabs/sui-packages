module 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft {
    struct TYPUS_NFT has drop {
        dummy_field: bool,
    }

    struct Tails has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        number: u64,
        url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        level: u64,
        exp: u64,
        first_bid: bool,
        first_deposit: bool,
        first_deposit_nft: bool,
        u64_padding: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Royalty has key {
        id: 0x2::object::UID,
        recipients: 0x2::vec_map::VecMap<address, u64>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Tails>,
    }

    struct RoyaltyUpdateEvent has copy, drop {
        sender: address,
        recipients: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        tails: 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::TableVec<Tails>,
        num: u64,
        is_live: bool,
        start_ms: u64,
    }

    struct NewManagerCapEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct ExpUpEvent has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        exp_earn: u64,
    }

    struct FirstBidEvent has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        exp_earn: u64,
    }

    struct FirstDepositEvent has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        exp_earn: u64,
    }

    struct LevelUpEvent has copy, drop {
        nft_id: 0x2::object::ID,
        level: u64,
    }

    struct MintEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        number: u64,
        url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        sender: address,
    }

    entry fun close_pool(arg0: &ManagerCap, arg1: Pool) {
        let Pool {
            id       : v0,
            tails    : v1,
            num      : _,
            is_live  : _,
            start_ms : _,
        } = arg1;
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::destroy_empty<Tails>(v1);
        0x2::object::delete(v0);
    }

    public fun contains_u64_padding(arg0: &ManagerCap, arg1: &Tails, arg2: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u64>(&arg1.u64_padding, &arg2)
    }

    entry fun deposit_nft(arg0: &ManagerCap, arg1: &mut Pool, arg2: 0x1::string::String, arg3: u64, arg4: vector<u8>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::push_back<Tails>(&mut arg1.tails, new_nft(arg2, arg3, 0x2::url::new_unsafe_from_bytes(arg4), 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::utils::from_vec_to_map<0x1::string::String, 0x1::string::String>(arg5, arg6), arg7));
        arg1.num = arg1.num + 1;
    }

    public(friend) fun emit_mint_event(arg0: &Tails, arg1: address) {
        let v0 = MintEvent{
            id          : 0x2::object::id<Tails>(arg0),
            name        : arg0.name,
            description : arg0.description,
            number      : arg0.number,
            url         : arg0.url,
            attributes  : arg0.attributes,
            sender      : arg1,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun first_bid(arg0: &ManagerCap, arg1: &mut Tails) {
        if (!arg1.first_bid) {
            arg1.first_bid = true;
            arg1.exp = arg1.exp + 500;
            let v0 = FirstBidEvent{
                nft_id   : 0x2::object::id<Tails>(arg1),
                number   : arg1.number,
                exp_earn : 500,
            };
            0x2::event::emit<FirstBidEvent>(v0);
        };
    }

    public fun first_deposit(arg0: &ManagerCap, arg1: &mut Tails) {
        if (!arg1.first_deposit) {
            arg1.first_deposit = true;
            arg1.exp = arg1.exp + 100;
            let v0 = FirstDepositEvent{
                nft_id   : 0x2::object::id<Tails>(arg1),
                number   : arg1.number,
                exp_earn : 100,
            };
            0x2::event::emit<FirstDepositEvent>(v0);
        };
    }

    public fun first_deposit_nft(arg0: &ManagerCap, arg1: &mut Tails) {
        if (!arg1.first_deposit_nft) {
            arg1.first_deposit_nft = true;
            arg1.exp = arg1.exp + 1000;
        };
    }

    entry fun free_mint(arg0: &mut Pool, arg1: &0x2::transfer_policy::TransferPolicy<Tails>, arg2: Whitelist, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg2, arg3, arg4);
        let (v1, v2) = 0x2::kiosk::new(arg4);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<Tails>(&mut v4, &v3, arg1, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg4));
    }

    entry fun free_mint_into_kiosk(arg0: &mut Pool, arg1: &0x2::transfer_policy::TransferPolicy<Tails>, arg2: Whitelist, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::lock<Tails>(arg3, arg4, arg1, mint(arg0, arg2, arg5, arg6));
    }

    fun get_level_exp(arg0: u64) : u64 {
        if (arg0 == 2) {
            1000
        } else if (arg0 == 3) {
            50000
        } else if (arg0 == 4) {
            250000
        } else if (arg0 == 5) {
            1000000
        } else if (arg0 == 6) {
            5000000
        } else if (arg0 == 7) {
            20000000
        } else {
            0
        }
    }

    public fun get_u64_padding(arg0: &ManagerCap, arg1: &Tails, arg2: 0x1::string::String) : u64 {
        *0x2::vec_map::get<0x1::string::String, u64>(&arg1.u64_padding, &arg2)
    }

    fun init(arg0: TYPUS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TYPUS_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Tails>(&v0, arg1);
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"exp"), 0x1::string::utf8(b"{exp}"));
        0x2::display::update_version<Tails>(&mut v1);
        let v2 = ManagerCap{id: 0x2::object::new(arg1)};
        let (v3, v4) = 0x2::transfer_policy::new<Tails>(&v0, arg1);
        let v5 = v4;
        let v6 = v3;
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::royalty_rule::add<Tails>(&mut v6, &v5, 1000, 1000000000);
        let v7 = 0x2::vec_map::empty<address, u64>();
        0x2::vec_map::insert<address, u64>(&mut v7, @0xe62c0a0509e2baa4700cd9b9bad8b1ba9296ecc1b36ff8122e29926efe1eb800, 5000);
        0x2::vec_map::insert<address, u64>(&mut v7, @0x585fff81dad10fc7fcdba55a815557ba263185b49307285002852e9fa981451d, 2000);
        0x2::vec_map::insert<address, u64>(&mut v7, @0x7a199f53557a804241ef6151677585e02708c27eca57111dea91043e1ed58410, 3000);
        let v8 = Royalty{
            id         : 0x2::object::new(arg1),
            recipients : v7,
            policy_cap : v5,
        };
        let v9 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v9);
        0x2::transfer::public_transfer<0x2::display::Display<Tails>>(v1, v9);
        0x2::transfer::public_transfer<ManagerCap>(v2, v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tails>>(v6);
        0x2::transfer::share_object<Royalty>(v8);
        let v10 = RoyaltyUpdateEvent{
            sender     : v9,
            recipients : v7,
        };
        0x2::event::emit<RoyaltyUpdateEvent>(v10);
    }

    public fun insert_u64_padding(arg0: &ManagerCap, arg1: &mut Tails, arg2: 0x1::string::String, arg3: u64) {
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.u64_padding, arg2, arg3);
    }

    entry fun issue_whitelist(arg0: &ManagerCap, arg1: &Pool, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = Whitelist{
                id  : 0x2::object::new(arg3),
                for : 0x2::object::id<Pool>(arg1),
            };
            0x2::transfer::transfer<Whitelist>(v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public fun level_up(arg0: &ManagerCap, arg1: &mut Tails) : 0x1::option::Option<u64> {
        let v0 = if (arg1.exp >= get_level_exp(7)) {
            7
        } else if (arg1.exp >= get_level_exp(6)) {
            6
        } else if (arg1.exp >= get_level_exp(5)) {
            5
        } else if (arg1.exp >= get_level_exp(4)) {
            4
        } else if (arg1.exp >= get_level_exp(3)) {
            3
        } else if (arg1.exp >= get_level_exp(2)) {
            2
        } else {
            1
        };
        arg1.level = v0;
        if (arg1.level != v0) {
            let v1 = LevelUpEvent{
                nft_id : 0x2::object::id<Tails>(arg1),
                level  : arg1.level,
            };
            0x2::event::emit<LevelUpEvent>(v1);
            return 0x1::option::some<u64>(arg1.level)
        };
        0x1::option::none<u64>()
    }

    fun mint(arg0: &mut Pool, arg1: Whitelist, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Tails {
        assert!(18446744073709551615 == arg0.start_ms, 4);
        assert!(arg0.is_live, 5);
        let v0 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::length<Tails>(&arg0.tails);
        assert!(v0 > 0, 3);
        let Whitelist {
            id  : v1,
            for : v2,
        } = arg1;
        0x2::object::delete(v1);
        assert!(v2 == 0x2::object::id<Pool>(arg0), 1);
        let v3 = if (v0 == 1) {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::pop_back<Tails>(&mut arg0.tails)
        } else {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::swap<Tails>(&mut arg0.tails, ((0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::utils::rand(arg3) % ((v0 - 1) as u256)) as u64), v0 - 1);
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::pop_back<Tails>(&mut arg0.tails)
        };
        let v4 = v3;
        let v5 = MintEvent{
            id          : 0x2::object::id<Tails>(&v4),
            name        : v4.name,
            description : v4.description,
            number      : v4.number,
            url         : v4.url,
            attributes  : v4.attributes,
            sender      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintEvent>(v5);
        v4
    }

    entry fun new_manager_cap(arg0: &ManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg1)};
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = NewManagerCapEvent{
            id     : 0x2::object::id<ManagerCap>(&v0),
            sender : v1,
        };
        0x2::event::emit<NewManagerCapEvent>(v2);
        0x2::transfer::public_transfer<ManagerCap>(v0, v1);
    }

    fun new_nft(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::url::Url, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : Tails {
        let v0 = 0x1::string::utf8(b"Tails /6,666 by Typus Finance.");
        0x1::string::insert(&mut v0, 6, 0x1::string::sub_string(&arg0, 16, 0x1::string::length(&arg0)));
        Tails{
            id                : 0x2::object::new(arg4),
            name              : arg0,
            description       : v0,
            number            : arg1,
            url               : arg2,
            attributes        : arg3,
            level             : 1,
            exp               : 0,
            first_bid         : false,
            first_deposit     : false,
            first_deposit_nft : false,
            u64_padding       : 0x2::vec_map::empty<0x1::string::String, u64>(),
        }
    }

    entry fun new_pool(arg0: &ManagerCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id       : 0x2::object::new(arg2),
            tails    : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::empty<Tails>(arg2),
            num      : 0,
            is_live  : false,
            start_ms : arg1,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun nft_exp_up(arg0: &ManagerCap, arg1: &mut Tails, arg2: u64) {
        arg1.exp = arg1.exp + arg2;
        let v0 = ExpUpEvent{
            nft_id   : 0x2::object::id<Tails>(arg1),
            number   : arg1.number,
            exp_earn : arg2,
        };
        0x2::event::emit<ExpUpEvent>(v0);
    }

    entry fun pool_set_n_level(arg0: &ManagerCap, arg1: &mut Pool, arg2: u64, arg3: u64) {
        assert!(0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::length<Tails>(&arg1.tails) >= arg2, 2);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::borrow_mut<Tails>(&mut arg1.tails, v0);
            v1.exp = get_level_exp(arg3);
            level_up(arg0, v1);
            v0 = v0 + 1;
        };
    }

    public fun remove_u64_padding(arg0: &ManagerCap, arg1: &mut Tails, arg2: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg1.u64_padding, &arg2);
    }

    entry fun resend_nfts_event(arg0: &ManagerCap, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: vector<u8>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"Tails /6,666 by Typus Finance.");
        0x1::string::insert(&mut v0, 6, 0x1::string::sub_string(&arg2, 16, 0x1::string::length(&arg2)));
        let v1 = MintEvent{
            id          : 0x2::object::id_from_address(arg1),
            name        : arg2,
            description : v0,
            number      : arg3,
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
            attributes  : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::utils::from_vec_to_map<0x1::string::String, 0x1::string::String>(arg5, arg6),
            sender      : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<MintEvent>(v1);
    }

    entry fun send_nfts(arg0: &ManagerCap, arg1: &mut Pool, arg2: &0x2::transfer_policy::TransferPolicy<Tails>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        while (arg4 > 0) {
            let v4 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::pop_back<Tails>(&mut arg1.tails);
            let v5 = MintEvent{
                id          : 0x2::object::id<Tails>(&v4),
                name        : v4.name,
                description : v4.description,
                number      : v4.number,
                url         : v4.url,
                attributes  : v4.attributes,
                sender      : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<MintEvent>(v5);
            0x2::kiosk::lock<Tails>(&mut v3, &v2, arg2, v4);
            arg4 = arg4 - 1;
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg3);
    }

    public fun tails_attributes(arg0: &Tails) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun tails_exp(arg0: &Tails) : u64 {
        arg0.exp
    }

    public fun tails_level(arg0: &Tails) : u64 {
        arg0.level
    }

    public fun tails_number(arg0: &Tails) : u64 {
        arg0.number
    }

    public fun update_image_url(arg0: &ManagerCap, arg1: &mut Tails, arg2: vector<u8>) {
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public(friend) fun update_nft(arg0: &ManagerCap, arg1: &mut Tails, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u8>) {
        assert!(0x2::object::id<Tails>(arg1) == arg2, 7);
        arg1.exp = get_level_exp(arg3);
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg4);
        level_up(arg0, arg1);
    }

    entry fun update_policy_rules(arg0: &ManagerCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<Tails>, arg2: &Royalty) {
        0x2::transfer_policy::remove_rule<Tails, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::royalty_rule::Rule, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::royalty_rule::Config>(arg1, &arg2.policy_cap);
        0xedfdc869d10349d96a4cd414ebe03551c4f6b6aa6dd4b76521bb13c174f79130::royalty_rule::add<Tails>(arg1, &arg2.policy_cap, 1000, 1000000000);
        0xedfdc869d10349d96a4cd414ebe03551c4f6b6aa6dd4b76521bb13c174f79130::kiosk_lock_rule::add<Tails>(arg1, &arg2.policy_cap);
    }

    entry fun update_pool_nft(arg0: &ManagerCap, arg1: &mut Pool, arg2: u64, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>) {
        let v0 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::borrow_mut<Tails>(&mut arg1.tails, arg2);
        update_nft(arg0, v0, arg3, arg4, arg5);
    }

    entry fun update_royalty(arg0: &ManagerCap, arg1: &mut Royalty, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 6);
        let v0 = 0x2::vec_map::empty<address, u64>();
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::vec_map::insert<address, u64>(&mut v0, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
        };
        arg1.recipients = v0;
        let v1 = RoyaltyUpdateEvent{
            sender     : 0x2::tx_context::sender(arg4),
            recipients : v0,
        };
        0x2::event::emit<RoyaltyUpdateEvent>(v1);
    }

    entry fun update_sale(arg0: &ManagerCap, arg1: &mut Pool, arg2: bool) {
        arg1.is_live = arg2;
    }

    entry fun update_start_ms(arg0: &ManagerCap, arg1: &mut Pool, arg2: u64) {
        arg1.start_ms = arg2;
    }

    public fun update_u64_padding(arg0: &ManagerCap, arg1: &mut Tails, arg2: 0x1::string::String, arg3: u64) {
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg1.u64_padding, &arg2) = arg3;
    }

    public(friend) fun withdraw_nfts(arg0: &ManagerCap, arg1: &mut Pool, arg2: u64) : vector<Tails> {
        let v0 = 0x1::vector::empty<Tails>();
        while (arg2 > 0) {
            0x1::vector::push_back<Tails>(&mut v0, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec::pop_back<Tails>(&mut arg1.tails));
            arg2 = arg2 - 1;
        };
        v0
    }

    entry fun withdraw_royalty(arg0: &ManagerCap, arg1: &Royalty, arg2: &mut 0x2::transfer_policy::TransferPolicy<Tails>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::withdraw<Tails>(arg2, &arg1.policy_cap, 0x1::option::none<u64>(), arg3);
        let v1 = 0x2::coin::balance_mut<0x2::sui::SUI>(&mut v0);
        let v2 = 0x2::vec_map::keys<address, u64>(&arg1.recipients);
        while (0x1::vector::length<address>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<address>(&mut v2);
            let v4 = if (0x1::vector::length<address>(&v2) > 0) {
                0x2::coin::value<0x2::sui::SUI>(&v0) * *0x2::vec_map::get<address, u64>(&arg1.recipients, &v3) / 10000
            } else {
                0x2::balance::value<0x2::sui::SUI>(v1)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v1, v4, arg3), v3);
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
    }

    // decompiled from Move bytecode v6
}

