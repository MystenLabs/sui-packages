module 0x72ad8f46d4fc3bbc24df15f6c62a98044c2649a9a31895a957254b2cf16e0cb9::profile {
    struct WrapperProfile has store, key {
        id: 0x2::object::UID,
        profile: vector<u8>,
        owner: address,
        url: 0x2::url::Url,
    }

    struct Global has key {
        id: 0x2::object::UID,
        creator: address,
        captcha_public_key: vector<u8>,
        profiles: 0x2::object_table::ObjectTable<address, WrapperProfile>,
        url: 0x2::url::Url,
    }

    public entry fun add_item<T0: store + key>(arg0: &mut Global, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut 0x2::object_table::borrow_mut<address, WrapperProfile>(&mut arg0.profiles, 0x2::tx_context::sender(arg2)).id, 0x2::object::id<T0>(&arg1), arg1);
    }

    public entry fun destroy(arg0: &mut Global, arg1: 0x72ad8f46d4fc3bbc24df15f6c62a98044c2649a9a31895a957254b2cf16e0cb9::dmens::DmensMeta, arg2: &mut 0x2::tx_context::TxContext) {
        let WrapperProfile {
            id      : v0,
            profile : _,
            owner   : _,
            url     : _,
        } = 0x2::object_table::remove<address, WrapperProfile>(&mut arg0.profiles, 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
        0x72ad8f46d4fc3bbc24df15f6c62a98044c2649a9a31895a957254b2cf16e0cb9::dmens::destory_all(arg1);
    }

    public fun global_verify(arg0: &Global, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.captcha_public_key, &arg2), 2);
    }

    public fun has_exsits(arg0: &Global, arg1: address) : bool {
        0x2::object_table::contains<address, WrapperProfile>(&arg0.profiles, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                 : 0x2::object::new(arg0),
            creator            : 0x2::tx_context::sender(arg0),
            captcha_public_key : x"2798a48215521de12536c72a3ac317a9b128b4b98cab18545b3ffe129be0e762",
            profiles           : 0x2::object_table::new<address, WrapperProfile>(arg0),
            url                : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibat54rwwfuxm377yj5vlhjhyj7cbzex2tdhktxmom6rdco54up5a"),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public entry fun register(arg0: &mut Global, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<vector<u8>>(&arg1));
        global_verify(arg0, arg2, 0x1::hash::sha3_256(v1));
        if (!has_exsits(arg0, v0)) {
            let v2 = WrapperProfile{
                id      : 0x2::object::new(arg3),
                profile : arg1,
                owner   : v0,
                url     : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibat54rwwfuxm377yj5vlhjhyj7cbzex2tdhktxmom6rdco54up5a"),
            };
            0x2::object_table::add<address, WrapperProfile>(&mut arg0.profiles, v0, v2);
            0x72ad8f46d4fc3bbc24df15f6c62a98044c2649a9a31895a957254b2cf16e0cb9::dmens::dmens_meta(arg3);
        };
        0x2::object_table::borrow_mut<address, WrapperProfile>(&mut arg0.profiles, v0).profile = arg1;
    }

    public entry fun remove_item<T0: store + key>(arg0: &mut Global, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut 0x2::object_table::borrow_mut<address, WrapperProfile>(&mut arg0.profiles, 0x2::tx_context::sender(arg2)).id, arg1), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_captcha_key(arg0: &mut Global, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.captcha_public_key = arg1;
    }

    // decompiled from Move bytecode v6
}

