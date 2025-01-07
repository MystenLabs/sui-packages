module 0xb92ec96a3b77f0872486e7b773e32e6e0bc4e99326c12499dceab4b1b56e7bfa::mover_nft {
    struct MOVER_NFT has drop {
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
        u64_padding: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Royalty has key {
        id: 0x2::object::UID,
        recipient: address,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Tails>,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        tails: 0x2::table_vec::TableVec<Tails>,
        num: u64,
        is_live: bool,
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

    struct ExpDownEvent has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        exp_remove: u64,
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
            id      : v0,
            tails   : v1,
            num     : _,
            is_live : _,
        } = arg1;
        0x2::table_vec::destroy_empty<Tails>(v1);
        0x2::object::delete(v0);
    }

    entry fun deposit_nft(arg0: &ManagerCap, arg1: &mut Pool, arg2: 0x1::string::String, arg3: u64, arg4: vector<u8>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::table_vec::push_back<Tails>(&mut arg1.tails, new_nft(arg2, arg3, 0x2::url::new_unsafe_from_bytes(arg4), 0xb92ec96a3b77f0872486e7b773e32e6e0bc4e99326c12499dceab4b1b56e7bfa::utils::from_vec_to_map<0x1::string::String, 0x1::string::String>(arg5, arg6), arg7));
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

    entry fun free_mint_into_kiosk(arg0: &mut Pool, arg1: &0x2::transfer_policy::TransferPolicy<Tails>, arg2: Whitelist, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
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

    fun init(arg0: MOVER_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MOVER_NFT>(arg0, arg1);
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Tails>(&mut v6, &v5, 1000, 1000000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Tails>(&mut v6, &v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<Tails>(&mut v6, &v5);
        let v7 = Royalty{
            id         : 0x2::object::new(arg1),
            recipient  : @0xd15f079d5f60b8fdfdcf3ca66c0d3473790c758b04b6418929d5d2991c5443ee,
            policy_cap : v5,
        };
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v8);
        0x2::transfer::public_transfer<0x2::display::Display<Tails>>(v1, v8);
        0x2::transfer::public_transfer<ManagerCap>(v2, v8);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tails>>(v6);
        0x2::transfer::share_object<Royalty>(v7);
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

    fun mint(arg0: &mut Pool, arg1: Whitelist, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : Tails {
        assert!(arg0.is_live, 3);
        let v0 = 0x2::table_vec::length<Tails>(&arg0.tails);
        assert!(v0 > 0, 2);
        let Whitelist {
            id  : v1,
            for : v2,
        } = arg1;
        0x2::object::delete(v1);
        assert!(v2 == 0x2::object::id<Pool>(arg0), 1);
        let v3 = if (v0 == 1) {
            0x2::table_vec::pop_back<Tails>(&mut arg0.tails)
        } else {
            let v4 = 0x2::random::new_generator(arg2, arg3);
            0x2::table_vec::swap<Tails>(&mut arg0.tails, 0x2::random::generate_u64_in_range(&mut v4, 0, v0 - 1), v0 - 1);
            0x2::table_vec::pop_back<Tails>(&mut arg0.tails)
        };
        let v5 = v3;
        let v6 = MintEvent{
            id          : 0x2::object::id<Tails>(&v5),
            name        : v5.name,
            description : v5.description,
            number      : v5.number,
            url         : v5.url,
            attributes  : v5.attributes,
            sender      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintEvent>(v6);
        v5
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
        Tails{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : 0x1::string::utf8(b"Tails by Sui Mover 2024."),
            number      : arg1,
            url         : arg2,
            attributes  : arg3,
            level       : 1,
            exp         : 0,
            u64_padding : 0x2::vec_map::empty<0x1::string::String, u64>(),
        }
    }

    entry fun new_pool(arg0: &ManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id      : 0x2::object::new(arg1),
            tails   : 0x2::table_vec::empty<Tails>(arg1),
            num     : 0,
            is_live : false,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun nft_exp_down(arg0: &ManagerCap, arg1: &mut Tails, arg2: u64) {
        arg1.exp = arg1.exp - arg2;
        let v0 = ExpDownEvent{
            nft_id     : 0x2::object::id<Tails>(arg1),
            number     : arg1.number,
            exp_remove : arg2,
        };
        0x2::event::emit<ExpDownEvent>(v0);
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

    entry fun send_nfts(arg0: &ManagerCap, arg1: &mut Pool, arg2: &0x2::transfer_policy::TransferPolicy<Tails>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        while (arg4 > 0) {
            let v4 = 0x2::table_vec::pop_back<Tails>(&mut arg1.tails);
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
        assert!(0x2::object::id<Tails>(arg1) == arg2, 4);
        arg1.exp = get_level_exp(arg3);
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg4);
        level_up(arg0, arg1);
    }

    entry fun update_pool_nft(arg0: &ManagerCap, arg1: &mut Pool, arg2: u64, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>) {
        let v0 = 0x2::table_vec::borrow_mut<Tails>(&mut arg1.tails, arg2);
        update_nft(arg0, v0, arg3, arg4, arg5);
    }

    entry fun update_sale(arg0: &ManagerCap, arg1: &mut Pool, arg2: bool) {
        arg1.is_live = arg2;
    }

    public(friend) fun withdraw_nfts(arg0: &ManagerCap, arg1: &mut Pool, arg2: u64) : vector<Tails> {
        let v0 = 0x1::vector::empty<Tails>();
        while (arg2 > 0) {
            0x1::vector::push_back<Tails>(&mut v0, 0x2::table_vec::pop_back<Tails>(&mut arg1.tails));
            arg2 = arg2 - 1;
        };
        v0
    }

    entry fun withdraw_royalty(arg0: &ManagerCap, arg1: &Royalty, arg2: &mut 0x2::transfer_policy::TransferPolicy<Tails>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<Tails>(arg2, &arg1.policy_cap, 0x1::option::none<u64>(), arg3), arg1.recipient);
    }

    // decompiled from Move bytecode v6
}

