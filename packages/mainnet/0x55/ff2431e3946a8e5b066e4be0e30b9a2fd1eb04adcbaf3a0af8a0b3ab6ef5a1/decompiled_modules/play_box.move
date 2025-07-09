module 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::play_box {
    struct PlayBox has store, key {
        id: 0x2::object::UID,
        payload: 0x2::table_vec::TableVec<vector<u256>>,
        max_size_per_item: u64,
        generate_at_once: u64,
    }

    struct PlayBoxEvent has copy, drop {
        uid: 0x1::string::String,
        generated_length: u64,
    }

    entry fun create(arg0: u64, arg1: u64, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg2, arg3);
        assert!(arg0 <= 1000, 13906834359026974719);
        assert!(arg1 > 0, 13906834363321942015);
        let v0 = PlayBox{
            id                : 0x2::object::new(arg3),
            payload           : 0x2::table_vec::empty<vector<u256>>(arg3),
            max_size_per_item : arg0,
            generate_at_once  : arg1,
        };
        0x2::transfer::public_share_object<PlayBox>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayBox{
            id                : 0x2::object::new(arg0),
            payload           : 0x2::table_vec::empty<vector<u256>>(arg0),
            max_size_per_item : 1000,
            generate_at_once  : 64,
        };
        0x2::transfer::public_share_object<PlayBox>(v0);
    }

    entry fun play(arg0: &mut PlayBox, arg1: vector<u8>, arg2: vector<u8>, arg3: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_op(arg3, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0PlayBox(), arg6);
        let v0 = 0x2::random::new_generator(arg4, arg6);
        let v1 = if (0x2::table_vec::length<vector<u256>>(&arg0.payload) == 0) {
            0x1::vector::empty<u256>()
        } else {
            0x2::table_vec::pop_back<vector<u256>>(&mut arg0.payload)
        };
        let v2 = v1;
        let v3 = 0;
        while (v3 < arg0.generate_at_once) {
            if (0x1::vector::length<u256>(&v2) >= arg0.max_size_per_item) {
                0x2::table_vec::push_back<vector<u256>>(&mut arg0.payload, v2);
                v2 = 0x1::vector::empty<u256>();
            };
            0x1::vector::push_back<u256>(&mut v2, 0x2::random::generate_u256(&mut v0));
            v3 = v3 + 1;
        };
        0x2::table_vec::push_back<vector<u256>>(&mut arg0.payload, v2);
        let (v4, _) = 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::auth::auth_once(&arg1, arg2, arg3, arg5);
        let v6 = PlayBoxEvent{
            uid              : v4,
            generated_length : v3,
        };
        0x2::event::emit<PlayBoxEvent>(v6);
    }

    entry fun update(arg0: &mut PlayBox, arg1: u64, arg2: u64, arg3: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg4: &0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg3, arg4);
        assert!(arg1 <= 1000, 13906834423451484159);
        arg0.max_size_per_item = arg1;
        arg0.generate_at_once = arg2;
    }

    // decompiled from Move bytecode v6
}

