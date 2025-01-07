module 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::timecapsule {
    struct TIMECAPSULE has drop {
        dummy_field: bool,
    }

    struct NewStoreEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct NewAdminCapEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct NewTimecapsuleEvent has copy, drop {
        id: 0x2::object::ID,
        for_round: u64,
        sui: u64,
    }

    struct NewDecryptedEvent has copy, drop {
        id: 0x2::object::ID,
        sui: u64,
    }

    struct TimecapsuleStore has key {
        id: 0x2::object::UID,
        version: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_permyriad: u256,
        fee_static: u256,
        fee_bag: 0x2::object_bag::ObjectBag,
        fee_token_permyriad: u256,
        count_minted: u256,
        meta: vector<u8>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Timecapsule has store, key {
        id: 0x2::object::UID,
        encrypted_prophecy: vector<u8>,
        prophecy: 0x1::string::String,
        image: 0x1::string::String,
        for_round: u64,
        decrypted: bool,
        object_bag: 0x2::object_bag::ObjectBag,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        meta: vector<u8>,
        level: u64,
    }

    public entry fun decrypt(arg0: &TimecapsuleStore, arg1: &mut Timecapsule, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        let v0 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::capsule::drand_quicknet();
        if (0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::capsule::verify_signature(&mut v0, arg1.for_round, &arg2) == false) {
            abort 2
        };
        arg1.prophecy = 0x1::string::utf8(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::capsule::decrypt(&v0, &arg1.encrypted_prophecy, arg2));
        arg1.decrypted = true;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui, v1, arg3), 0x2::tx_context::sender(arg3));
        };
        let v2 = NewDecryptedEvent{
            id  : 0x2::object::uid_to_inner(&arg1.id),
            sui : v1,
        };
        0x2::event::emit<NewDecryptedEvent>(v2);
    }

    public entry fun collect_coin_fees<T0>(arg0: &mut TimecapsuleStore, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::object_bag::contains<0x1::ascii::String>(&arg0.fee_bag, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::object_bag::remove<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.fee_bag, v0), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun collect_fees(arg0: &mut TimecapsuleStore, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: TIMECAPSULE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TIMECAPSULE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"TimeCapsule"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://hexcapsule.com/capsule/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{prophecy}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://hexcapsule.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"HexCapsule"));
        let v5 = 0x2::display::new_with_fields<Timecapsule>(&v0, v1, v3, arg1);
        0x2::display::update_version<Timecapsule>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Timecapsule>>(v5, 0x2::tx_context::sender(arg1));
        make_and_share_store(arg1);
    }

    fun make_and_share_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = TimecapsuleStore{
            id                  : 0x2::object::new(arg0),
            version             : 1,
            fee                 : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_permyriad       : 50,
            fee_static          : 100000000,
            fee_bag             : 0x2::object_bag::new(arg0),
            fee_token_permyriad : 100,
            count_minted        : 0,
            meta                : 0x1::vector::empty<u8>(),
        };
        let v2 = NewStoreEvent{id: 0x2::object::uid_to_inner(&v1.id)};
        0x2::event::emit<NewStoreEvent>(v2);
        let v3 = NewAdminCapEvent{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<NewAdminCapEvent>(v3);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<TimecapsuleStore>(v1);
    }

    public entry fun mint_with_sui(arg0: &mut TimecapsuleStore, arg1: vector<u8>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        if (arg2 < 1) {
            abort 3
        };
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = ((arg0.fee_static + (v0 as u256) * arg0.fee_permyriad / 10000) as u64);
        if (v0 < v1) {
            abort 4
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4));
        let v2 = Timecapsule{
            id                 : 0x2::object::new(arg4),
            encrypted_prophecy : arg1,
            prophecy           : 0x1::string::utf8(b"secret"),
            image              : 0x1::string::utf8(b"https://suidouble.github.io/hexcapsule/capsule.png"),
            for_round          : arg2,
            decrypted          : false,
            object_bag         : 0x2::object_bag::new(arg4),
            sui                : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            meta               : 0x1::vector::empty<u8>(),
            level              : 0,
        };
        let v3 = NewTimecapsuleEvent{
            id        : 0x2::object::uid_to_inner(&v2.id),
            for_round : arg2,
            sui       : 0x2::balance::value<0x2::sui::SUI>(&v2.sui),
        };
        0x2::event::emit<NewTimecapsuleEvent>(v3);
        arg0.count_minted = arg0.count_minted + 1;
        0x2::transfer::transfer<Timecapsule>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun put_coin_to_bag<T0>(arg0: &mut TimecapsuleStore, arg1: &mut Timecapsule, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        let v0 = &mut arg2;
        take_coin_fee<T0>(arg0, v0, arg3);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::object_bag::contains<0x1::ascii::String>(&arg1.object_bag, v1)) {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg1.object_bag, v1), arg2);
        } else {
            arg1.level = arg1.level + 1;
            if (arg1.level == 1) {
                arg1.image = 0x1::string::utf8(b"https://suidouble.github.io/hexcapsule/capsule_gold.png");
            } else if (arg1.level == 2) {
                arg1.image = 0x1::string::utf8(b"https://suidouble.github.io/hexcapsule/capsule_super.png");
            };
            0x2::object_bag::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg1.object_bag, v1, arg2);
        };
    }

    fun take_coin_fee<T0>(arg0: &mut TimecapsuleStore, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::object_bag::contains<0x1::ascii::String>(&arg0.fee_bag, v0)) {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.fee_bag, v0), 0x2::coin::split<T0>(arg1, (((0x2::coin::value<T0>(arg1) as u256) * arg0.fee_token_permyriad / 10000) as u64), arg2));
        } else {
            0x2::object_bag::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.fee_bag, v0, 0x2::coin::split<T0>(arg1, (((0x2::coin::value<T0>(arg1) as u256) * arg0.fee_token_permyriad / 10000) as u64), arg2));
        };
    }

    public entry fun take_out_coin<T0>(arg0: &mut TimecapsuleStore, arg1: &mut Timecapsule, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        if (!arg1.decrypted) {
            abort 6
        };
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::object_bag::contains<0x1::ascii::String>(&arg1.object_bag, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::object_bag::remove<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg1.object_bag, v0), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

