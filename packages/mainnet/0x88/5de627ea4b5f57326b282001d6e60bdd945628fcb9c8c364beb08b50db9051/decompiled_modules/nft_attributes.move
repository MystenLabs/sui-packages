module 0x885de627ea4b5f57326b282001d6e60bdd945628fcb9c8c364beb08b50db9051::nft_attributes {
    struct NftAttributes has drop, store {
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun accessory_key() : 0x1::string::String {
        0x1::string::utf8(b"accessory")
    }

    public fun add_attribute(arg0: &mut NftAttributes, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, arg1, arg2);
    }

    public fun aura_key() : 0x1::string::String {
        0x1::string::utf8(b"aura")
    }

    public fun background_key() : 0x1::string::String {
        0x1::string::utf8(b"background")
    }

    public fun clothing_key() : 0x1::string::String {
        0x1::string::utf8(b"clothing")
    }

    public fun color_key() : 0x1::string::String {
        0x1::string::utf8(b"color")
    }

    public fun create(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : NftAttributes {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 0);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        NftAttributes{attributes: v0}
    }

    public fun create_with_common_traits(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : NftAttributes {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, background_key());
        0x1::vector::push_back<0x1::string::String>(v1, hat_key());
        0x1::vector::push_back<0x1::string::String>(v1, clothing_key());
        0x1::vector::push_back<0x1::string::String>(v1, eyes_key());
        0x1::vector::push_back<0x1::string::String>(v1, mouth_key());
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg0);
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, arg3);
        0x1::vector::push_back<0x1::string::String>(v3, arg4);
        create(v0, v2, arg5)
    }

    public fun edition_key() : 0x1::string::String {
        0x1::string::utf8(b"edition")
    }

    public fun expression_key() : 0x1::string::String {
        0x1::string::utf8(b"expression")
    }

    public fun eyes_key() : 0x1::string::String {
        0x1::string::utf8(b"eyes")
    }

    public fun get_attributes(arg0: &NftAttributes) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun glasses_key() : 0x1::string::String {
        0x1::string::utf8(b"glasses")
    }

    public fun hair_key() : 0x1::string::String {
        0x1::string::utf8(b"hair")
    }

    public fun hat_key() : 0x1::string::String {
        0x1::string::utf8(b"hat")
    }

    public fun jewelry_key() : 0x1::string::String {
        0x1::string::utf8(b"jewelry")
    }

    public fun material_key() : 0x1::string::String {
        0x1::string::utf8(b"material")
    }

    public fun mouth_key() : 0x1::string::String {
        0x1::string::utf8(b"mouth")
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : NftAttributes {
        NftAttributes{attributes: 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()}
    }

    public fun pattern_key() : 0x1::string::String {
        0x1::string::utf8(b"pattern")
    }

    public fun pose_key() : 0x1::string::String {
        0x1::string::utf8(b"pose")
    }

    public fun remove_attribute(arg0: &mut NftAttributes, arg1: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg1);
    }

    public fun shoes_key() : 0x1::string::String {
        0x1::string::utf8(b"shoes")
    }

    public fun skin_key() : 0x1::string::String {
        0x1::string::utf8(b"skin")
    }

    public fun tattoo_key() : 0x1::string::String {
        0x1::string::utf8(b"tattoo")
    }

    public fun weapon_key() : 0x1::string::String {
        0x1::string::utf8(b"weapon")
    }

    // decompiled from Move bytecode v6
}

