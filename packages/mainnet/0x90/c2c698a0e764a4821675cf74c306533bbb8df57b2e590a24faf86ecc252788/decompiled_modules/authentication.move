module 0x90c2c698a0e764a4821675cf74c306533bbb8df57b2e590a24faf86ecc252788::authentication {
    struct Registry has store, key {
        id: 0x2::object::UID,
    }

    struct Config has drop, store {
        address: address,
        input: vector<0x1::string::String>,
        output: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct HolderCap<T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::borrow::Referent<T0>,
        owner: address,
    }

    struct Protocol<phantom T0> has store, key {
        id: 0x2::object::UID,
        config: Config,
    }

    struct Authentication<phantom T0> has drop {
        initiater: address,
        output: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun destroy<T0: store + key, T1>(arg0: HolderCap<T0>, arg1: Protocol<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 102);
        let HolderCap {
            id    : v1,
            cap   : v2,
            owner : _,
        } = arg0;
        0x2::transfer::public_transfer<T0>(0x2::borrow::destroy<T0>(v2), v0);
        0x2::object::delete(v1);
        let Protocol {
            id     : v4,
            config : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    public fun new<T0>(arg0: &mut Registry, arg1: address, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &T0, arg5: &mut 0x2::tx_context::TxContext) : Protocol<T0> {
        0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg0.id, 0x90c2c698a0e764a4821675cf74c306533bbb8df57b2e590a24faf86ecc252788::utils::type_to_string<T0>(), true);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v2 = v0;
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::vector::pop_back<0x1::string::String>(&mut arg3), 0x1::string::utf8(b""));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg3);
        let v3 = Config{
            address : arg1,
            input   : arg2,
            output  : v0,
        };
        Protocol<T0>{
            id     : 0x2::object::new(arg5),
            config : v3,
        }
    }

    public fun create_and_store_cap<T0: store + key, T1>(arg0: &Protocol<T1>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = HolderCap<T0>{
            id    : 0x2::object::new(arg2),
            cap   : 0x2::borrow::new<T0>(arg1, arg2),
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<HolderCap<T0>>(v0);
    }

    public fun default<T0: store + key, T1>(arg0: &mut Registry, arg1: T0, arg2: address, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &T1, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T1>(arg0, arg2, arg3, arg4, arg5, arg6);
        create_and_store_cap<T0, T1>(&v0, arg1, arg6);
        0x2::transfer::share_object<Protocol<T1>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun into_keys<T0>(arg0: &Protocol<T0>) : vector<0x1::string::String> {
        arg0.config.input
    }

    public fun return_key<T0: store + key>(arg0: &mut HolderCap<T0>, arg1: T0, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<T0>(&mut arg0.cap, arg1, arg2);
    }

    public fun signin<T0: store + key, T1>(arg0: &Protocol<T1>, arg1: &mut HolderCap<T0>, arg2: vector<u8>, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : Authentication<T0> {
        let (v0, v1) = 0x90c2c698a0e764a4821675cf74c306533bbb8df57b2e590a24faf86ecc252788::utils::extract_signature_and_pubilc_key(arg2);
        let v2 = v1;
        let v3 = v0;
        assert!(arg0.config.address == 0x90c2c698a0e764a4821675cf74c306533bbb8df57b2e590a24faf86ecc252788::utils::derive_address_from_ed25519(v2), 103);
        let v4 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v5 = 0x1::string::utf8(b"0x");
        let v6 = into_keys<T1>(arg0);
        0x1::vector::reverse<0x1::string::String>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::string::String>(&v6)) {
            let v8 = v5;
            let v9 = 0x1::vector::pop_back<0x1::string::String>(&mut v6);
            if (v9 == 0x1::string::utf8(b"sender")) {
                0x1::string::append(&mut v8, 0x2::address::to_string(0x2::tx_context::sender(arg4)));
            } else if (v9 == 0x1::string::utf8(b"type")) {
                0x1::string::append(&mut v8, 0x90c2c698a0e764a4821675cf74c306533bbb8df57b2e590a24faf86ecc252788::utils::type_to_string<T0>());
            } else {
                0x1::string::append(&mut v8, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg3, &v9));
            };
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.config.output, &v9)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, v9, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg3, &v9));
            };
            v5 = v8;
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v6);
        let v10 = 0x90c2c698a0e764a4821675cf74c306533bbb8df57b2e590a24faf86ecc252788::utils::hash_message(0x1::string::into_bytes(v5));
        assert!(0x2::ed25519::ed25519_verify(&v3, &v2, &v10), 102);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg1.id, v2, true);
        Authentication<T0>{
            initiater : 0x2::tx_context::sender(arg4),
            output    : v4,
        }
    }

    public fun take_key<T0: store + key>(arg0: &mut HolderCap<T0>, arg1: Authentication<T0>) : (T0, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<T0>(&mut arg0.cap)
    }

    // decompiled from Move bytecode v6
}

