module 0x4717a50da98ea2938b6c2efd2f6516cc1618c6c1529f00f5144c68f5ba1c48c9::inscriptions_collection {
    struct CollectionConfig has store, key {
        id: 0x2::object::UID,
        current_id: u256,
        version: u64,
        admin: address,
    }

    struct Inscriptions<phantom T0> has store, key {
        id: 0x2::object::UID,
        current_id: u256,
        name: 0x1::string::String,
        description: 0x1::string::String,
        external_link: 0x1::string::String,
        content: 0x1::string::String,
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionConfig{
            id         : 0x2::object::new(arg0),
            current_id : 0,
            version    : 1,
            admin      : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
        };
        0x2::transfer::public_share_object<CollectionConfig>(v0);
    }

    public entry fun migrate_version(arg0: &mut CollectionConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.version = 1;
    }

    public fun mint_inscriptions_nft(arg0: &mut CollectionConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = arg0.current_id + 1;
        if (v0 <= 10000) {
            mint_nft<0x4717a50da98ea2938b6c2efd2f6516cc1618c6c1529f00f5144c68f5ba1c48c9::collection::Sub10K>(arg1, arg2, v0, arg3, arg4, arg5);
        } else if (v0 > 10000 && v0 <= 20000) {
            mint_nft<0x4717a50da98ea2938b6c2efd2f6516cc1618c6c1529f00f5144c68f5ba1c48c9::collection::Sub20K>(arg1, arg2, v0, arg3, arg4, arg5);
        } else if (v0 > 20000 && v0 <= 50000) {
            mint_nft<0x4717a50da98ea2938b6c2efd2f6516cc1618c6c1529f00f5144c68f5ba1c48c9::collection::Sub50K>(arg1, arg2, v0, arg3, arg4, arg5);
        } else if (v0 > 50000 && v0 <= 100000) {
            mint_nft<0x4717a50da98ea2938b6c2efd2f6516cc1618c6c1529f00f5144c68f5ba1c48c9::collection::Sub100K>(arg1, arg2, v0, arg3, arg4, arg5);
        } else if (v0 > 100000 && v0 <= 200000) {
            mint_nft<0x4717a50da98ea2938b6c2efd2f6516cc1618c6c1529f00f5144c68f5ba1c48c9::collection::Sub200K>(arg1, arg2, v0, arg3, arg4, arg5);
        } else if (v0 > 200000 && v0 <= 500000) {
            mint_nft<0x4717a50da98ea2938b6c2efd2f6516cc1618c6c1529f00f5144c68f5ba1c48c9::collection::Sub500K>(arg1, arg2, v0, arg3, arg4, arg5);
        };
    }

    fun mint_nft<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u256, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Inscriptions<T0>{
            id            : 0x2::object::new(arg5),
            current_id    : arg2,
            name          : arg0,
            description   : arg1,
            external_link : arg3,
            content       : arg4,
        };
        0x2::transfer::public_transfer<Inscriptions<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun set_new_admin(arg0: &mut CollectionConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

