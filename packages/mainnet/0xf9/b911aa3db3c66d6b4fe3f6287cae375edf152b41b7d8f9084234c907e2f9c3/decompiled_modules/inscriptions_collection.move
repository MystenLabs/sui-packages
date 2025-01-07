module 0xf9b911aa3db3c66d6b4fe3f6287cae375edf152b41b7d8f9084234c907e2f9c3::inscriptions_collection {
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
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        contents: vector<0x1::string::String>,
        content_size: u64,
    }

    struct InstructionsNft has copy, drop {
        id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        current_id: u256,
    }

    struct BurnInstructionsNft has copy, drop {
        id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        current_id: u256,
    }

    fun assert_type_name<T0, T1>() {
        assert!(get_type_name<T0>() == get_type_name<T1>(), 3);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public entry fun burnt_nft<T0>(arg0: Inscriptions<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Inscriptions {
            id            : v0,
            current_id    : v1,
            name          : v2,
            description   : v3,
            image_url     : v4,
            external_link : v5,
            contents      : _,
            content_size  : _,
        } = arg0;
        let v8 = v0;
        let v9 = BurnInstructionsNft{
            id            : 0x2::object::uid_to_inner(&v8),
            nft_type      : get_type_name<T0>(),
            name          : v2,
            description   : v3,
            image_url     : v4,
            external_link : v5,
            current_id    : v1,
        };
        0x2::event::emit<BurnInstructionsNft>(v9);
        0x2::object::delete(v8);
    }

    fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
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

    public fun inscriptions<T0>(arg0: &mut CollectionConfig, arg1: &mut Inscriptions<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert!(0x1::vector::length<0x1::string::String>(&arg1.contents) + 1 <= arg1.content_size, 2);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.contents, arg2);
    }

    public entry fun migrate_version(arg0: &mut CollectionConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.version = 1;
    }

    public fun mint_inscriptions_nft<T0>(arg0: &mut CollectionConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Inscriptions<T0> {
        assert_version(arg0.version);
        let v0 = arg0.current_id + 1;
        if (v0 <= 10000) {
            assert_type_name<T0, 0xf9b911aa3db3c66d6b4fe3f6287cae375edf152b41b7d8f9084234c907e2f9c3::collection::Sub10K>();
        } else if (v0 > 10000 && v0 <= 20000) {
            assert_type_name<T0, 0xf9b911aa3db3c66d6b4fe3f6287cae375edf152b41b7d8f9084234c907e2f9c3::collection::Sub20K>();
        } else if (v0 > 20000 && v0 <= 50000) {
            assert_type_name<T0, 0xf9b911aa3db3c66d6b4fe3f6287cae375edf152b41b7d8f9084234c907e2f9c3::collection::Sub50K>();
        } else if (v0 > 50000 && v0 <= 100000) {
            assert_type_name<T0, 0xf9b911aa3db3c66d6b4fe3f6287cae375edf152b41b7d8f9084234c907e2f9c3::collection::Sub100K>();
        } else if (v0 > 100000 && v0 <= 200000) {
            assert_type_name<T0, 0xf9b911aa3db3c66d6b4fe3f6287cae375edf152b41b7d8f9084234c907e2f9c3::collection::Sub200K>();
        } else if (v0 > 200000 && v0 <= 500000) {
            assert_type_name<T0, 0xf9b911aa3db3c66d6b4fe3f6287cae375edf152b41b7d8f9084234c907e2f9c3::collection::Sub500K>();
        };
        mint_nft<T0>(arg1, arg2, v0, arg3, arg4, arg5, arg6)
    }

    fun mint_nft<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u256, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Inscriptions<T0> {
        let v0 = Inscriptions<T0>{
            id            : 0x2::object::new(arg6),
            current_id    : arg2,
            name          : arg0,
            description   : arg1,
            image_url     : arg3,
            external_link : arg4,
            contents      : 0x1::vector::empty<0x1::string::String>(),
            content_size  : arg5,
        };
        let v1 = InstructionsNft{
            id            : 0x2::object::uid_to_inner(&v0.id),
            nft_type      : get_type_name<T0>(),
            name          : arg0,
            description   : arg1,
            image_url     : arg3,
            external_link : arg4,
            current_id    : arg2,
        };
        0x2::event::emit<InstructionsNft>(v1);
        v0
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

