module 0x408d22066775f20e0c13617c1f157a110d9a5b0873b878692b78aba92b1a46e1::discord {
    struct DiscordApp has drop {
        dummy_field: bool,
    }

    struct DiscordCap has store, key {
        id: 0x2::object::UID,
    }

    struct Owner has drop, store {
        updates: u32,
        addr: 0x1::option::Option<address>,
    }

    struct Member has drop, store {
        available_points: u64,
        roles: 0x2::vec_set::VecSet<u8>,
        claimed_coupons: vector<0x1::string::String>,
        owner: Owner,
    }

    struct Discord has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        discord_roles: 0x2::vec_map::VecMap<u8, u8>,
        users: 0x2::table::Table<0x1::string::String, Member>,
    }

    public fun add_discord_role(arg0: &DiscordCap, arg1: &mut Discord, arg2: u8, arg3: u8) {
        assert_is_valid_discount(arg3);
        assert!(!0x2::vec_map::contains<u8, u8>(&arg1.discord_roles, &arg2), 2);
        0x2::vec_map::insert<u8, u8>(&mut arg1.discord_roles, arg2, arg3);
    }

    fun add_roles_internal(arg0: &mut Member, arg1: vector<u8>, arg2: &0x2::vec_map::VecMap<u8, u8>) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 4);
        while (!0x1::vector::is_empty<u8>(&arg1)) {
            let v0 = 0x1::vector::pop_back<u8>(&mut arg1);
            assert!(!0x2::vec_set::contains<u8>(&arg0.roles, &v0), 6);
            assert!(0x2::vec_map::contains<u8, u8>(arg2, &v0), 5);
            0x2::vec_set::insert<u8>(&mut arg0.roles, v0);
            arg0.available_points = arg0.available_points + (*0x2::vec_map::get<u8, u8>(arg2, &v0) as u64);
        };
    }

    public fun assert_is_valid_discount(arg0: u8) {
        assert!(arg0 > 0 && arg0 <= 100, 1);
    }

    public fun attach_roles(arg0: &mut Discord, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0.public_key) > 0, 10);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"roles_");
        0x1::vector::append<u8>(&mut v0, *0x1::string::bytes(&arg2));
        0x1::vector::append<u8>(&mut v0, b"|");
        0x1::vector::append<u8>(&mut v0, arg3);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg1, &arg0.public_key, &v0, 1), 7);
        if (!0x2::table::contains<0x1::string::String, Member>(&arg0.users, arg2)) {
            0x2::table::add<0x1::string::String, Member>(&mut arg0.users, arg2, new_member());
        };
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Member>(&mut arg0.users, arg2);
        add_roles_internal(v1, arg3, &arg0.discord_roles);
    }

    public fun available_points(arg0: &Member) : u64 {
        arg0.available_points
    }

    public fun claim_coupon(arg0: &mut Discord, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DiscordApp{dummy_field: false};
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon_house::app_add_coupon(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon_house::app_data_mut<DiscordApp>(arg1, v0), claim_coupon_internal(arg0, arg2, arg3, arg4), 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::constants::percentage_discount_type(), (arg3 as u64), 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::new_coupon_rules(0x1::option::none<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(), 0x1::option::some<u64>(1), 0x1::option::some<address>(0x2::tx_context::sender(arg4)), 0x1::option::none<u64>(), 0x1::option::some<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::new(1, 1))), arg4);
    }

    public(friend) fun claim_coupon_internal(arg0: &mut Discord, arg1: 0x1::string::String, arg2: u8, arg3: &0x2::tx_context::TxContext) : 0x1::string::String {
        assert_is_valid_discount(arg2);
        assert!(0x2::table::contains<0x1::string::String, Member>(&arg0.users, arg1), 3);
        let v0 = 0x2::table::borrow<0x1::string::String, Member>(&arg0.users, arg1);
        let v1 = if (0x1::option::is_some<address>(&v0.owner.addr)) {
            let v2 = 0x2::tx_context::sender(arg3);
            0x1::option::borrow<address>(&v0.owner.addr) == &v2
        } else {
            false
        };
        assert!(v1, 8);
        let v3 = 0x2::table::borrow_mut<0x1::string::String, Member>(&mut arg0.users, arg1);
        assert!(v3.available_points >= (arg2 as u64), 9);
        let v4 = 0x1::vector::length<0x1::string::String>(&v3.claimed_coupons);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&v4));
        let v7 = 0x2::bcs::to_bytes<vector<vector<u8>>>(&v5);
        let v8 = 0x2::address::to_string(0x2::address::from_bytes(0x2::hash::blake2b256(&v7)));
        v3.available_points = v3.available_points - (arg2 as u64);
        0x1::vector::push_back<0x1::string::String>(&mut v3.claimed_coupons, v8);
        v8
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Discord{
            id            : 0x2::object::new(arg0),
            public_key    : 0x1::vector::empty<u8>(),
            discord_roles : 0x2::vec_map::empty<u8, u8>(),
            users         : 0x2::table::new<0x1::string::String, Member>(arg0),
        };
        0x2::transfer::share_object<Discord>(v0);
        let v1 = DiscordCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DiscordCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun member(arg0: &Discord, arg1: 0x1::string::String) : &Member {
        0x2::table::borrow<0x1::string::String, Member>(&arg0.users, arg1)
    }

    fun new_member() : Member {
        let v0 = Owner{
            updates : 0,
            addr    : 0x1::option::none<address>(),
        };
        Member{
            available_points : 0,
            roles            : 0x2::vec_set::empty<u8>(),
            claimed_coupons  : 0x1::vector::empty<0x1::string::String>(),
            owner            : v0,
        }
    }

    public fun set_address(arg0: &mut Discord, arg1: vector<u8>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0.public_key) > 0, 10);
        let v0 = if (!0x2::table::contains<0x1::string::String, Member>(&arg0.users, arg2)) {
            0x2::table::add<0x1::string::String, Member>(&mut arg0.users, arg2, new_member());
            0x2::table::borrow_mut<0x1::string::String, Member>(&mut arg0.users, arg2)
        } else {
            0x2::table::borrow_mut<0x1::string::String, Member>(&mut arg0.users, arg2)
        };
        let v1 = v0.owner.updates;
        v0.owner.addr = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        v0.owner.updates = v1 + 1;
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"address_");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u32>(&v1));
        0x1::vector::append<u8>(&mut v2, b"|");
        0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&arg2));
        0x1::vector::append<u8>(&mut v2, b"|");
        0x1::vector::append<u8>(&mut v2, 0x2::address::to_bytes(0x2::tx_context::sender(arg3)));
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg1, &arg0.public_key, &v2, 1), 7);
    }

    public fun set_public_key(arg0: &DiscordCap, arg1: &mut Discord, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 0);
        arg1.public_key = arg2;
    }

    // decompiled from Move bytecode v6
}

