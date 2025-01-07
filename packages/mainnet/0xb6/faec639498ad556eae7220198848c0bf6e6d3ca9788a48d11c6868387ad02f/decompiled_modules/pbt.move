module 0xb6faec639498ad556eae7220198848c0bf6e6d3ca9788a48d11c6868387ad02f::pbt {
    struct PBT has drop {
        dummy_field: bool,
    }

    struct QTConfiguration has store, key {
        id: 0x2::object::UID,
        chip_used_validation_enabled: bool,
    }

    struct PhysicalArtifactToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        chip_pk: vector<u8>,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        video_url: 0x1::string::String,
        external_url: 0x1::string::String,
        attributes: vector<PhysicalArtifactTokenAttribute>,
    }

    struct PhysicalArtifactTokenAttribute has store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct PhysicalArtifactArchive has store, key {
        id: 0x2::object::UID,
    }

    fun add_to_archive_(arg0: &mut PhysicalArtifactArchive, arg1: vector<u8>) {
        0x2::dynamic_field::add<vector<u8>, u8>(&mut arg0.id, arg1, 0);
    }

    public fun admin_add_to_archive(arg0: &0xb6faec639498ad556eae7220198848c0bf6e6d3ca9788a48d11c6868387ad02f::rkey::AdminCap, arg1: &mut PhysicalArtifactArchive, arg2: vector<u8>) {
        add_to_archive_(arg1, arg2);
    }

    public fun admin_enable_used_chip(arg0: &0xb6faec639498ad556eae7220198848c0bf6e6d3ca9788a48d11c6868387ad02f::rkey::AdminCap, arg1: &mut QTConfiguration, arg2: bool) {
        arg1.chip_used_validation_enabled = arg2;
    }

    fun init(arg0: PBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = QTConfiguration{
            id                           : 0x2::object::new(arg1),
            chip_used_validation_enabled : true,
        };
        let v1 = PhysicalArtifactArchive{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<PhysicalArtifactArchive>(v1);
        0x2::transfer::share_object<QTConfiguration>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PBT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint<T0: store>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: &mut PhysicalArtifactArchive, arg11: &QTConfiguration, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg11.chip_used_validation_enabled) {
            assert!(*0x2::dynamic_field::borrow<vector<u8>, u8>(&arg10.id, arg2) == 0, 4);
        };
        assert!(0xb6faec639498ad556eae7220198848c0bf6e6d3ca9788a48d11c6868387ad02f::signature::verify_signature_simple(arg0, arg1, arg12), 1);
        let v0 = 0x1::vector::empty<PhysicalArtifactTokenAttribute>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg8)) {
            let v2 = PhysicalArtifactTokenAttribute{
                trait_type : *0x1::vector::borrow<0x1::string::String>(&arg8, v1),
                value      : *0x1::vector::borrow<0x1::string::String>(&arg9, v1),
            };
            0x1::vector::push_back<PhysicalArtifactTokenAttribute>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = PhysicalArtifactToken<T0>{
            id           : 0x2::object::new(arg12),
            chip_pk      : arg1,
            name         : arg3,
            description  : arg4,
            image_url    : arg5,
            video_url    : arg6,
            external_url : arg7,
            attributes   : v0,
        };
        update_archive_(arg10, arg2, 1);
        0x2::transfer::transfer<PhysicalArtifactToken<T0>>(v3, 0x2::tx_context::sender(arg12));
    }

    fun remove_from_archive_(arg0: &mut PhysicalArtifactArchive, arg1: vector<u8>) {
        0x2::dynamic_field::remove<vector<u8>, u8>(&mut arg0.id, arg1);
    }

    public fun setup_display<T0: store>(arg0: &0xb6faec639498ad556eae7220198848c0bf6e6d3ca9788a48d11c6868387ad02f::rkey::AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"chip_pk"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"video_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"external_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{chip_pk}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{video_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        let v4 = 0x2::display::new_with_fields<PhysicalArtifactToken<T0>>(arg1, v0, v2, arg2);
        0x2::display::update_version<PhysicalArtifactToken<T0>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<PhysicalArtifactToken<T0>>>(v4, 0x2::tx_context::sender(arg2));
    }

    public fun transfer_ownership_to_address<T0>(arg0: vector<u8>, arg1: PhysicalArtifactToken<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 5);
        assert!(0xb6faec639498ad556eae7220198848c0bf6e6d3ca9788a48d11c6868387ad02f::signature::verify_signature_simple(arg0, arg1.chip_pk, arg3), 1);
        0x2::transfer::transfer<PhysicalArtifactToken<T0>>(arg1, arg2);
    }

    fun update_archive_(arg0: &mut PhysicalArtifactArchive, arg1: vector<u8>, arg2: u8) {
        *0x2::dynamic_field::borrow_mut<vector<u8>, u8>(&mut arg0.id, arg1) = arg2;
    }

    public fun update_chip_pk<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut PhysicalArtifactToken<T0>, arg4: &mut PhysicalArtifactArchive, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg4.id, arg2), 3);
        assert!(0xb6faec639498ad556eae7220198848c0bf6e6d3ca9788a48d11c6868387ad02f::signature::verify_signature_simple(arg0, arg1, arg5), 1);
        remove_from_archive_(arg4, arg3.chip_pk);
        arg3.chip_pk = arg2;
        update_archive_(arg4, arg2, 1);
    }

    // decompiled from Move bytecode v6
}

