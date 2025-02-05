module 0xb781ab96e221866835baa29d6ea751f0829650dab7b105947832b213176d4d98::maniac_attribute {
    struct Admin has store {
        admin_address: address,
    }

    struct MintingControl has store, key {
        id: 0x2::object::UID,
        admin: Admin,
    }

    struct MANIAC_ATTRIBUTE has drop {
        dummy_field: bool,
    }

    struct ManiacAttributeNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        field_type: 0x1::string::String,
        field_value: 0x1::string::String,
    }

    struct AttributeMappingItem has store {
        probabilities: vector<u64>,
        id_to_value: 0x2::table::Table<u64, vector<u8>>,
    }

    struct AttributeMapping has store, key {
        id: 0x2::object::UID,
        background: AttributeMappingItem,
        body: AttributeMappingItem,
        hat: AttributeMappingItem,
        beard: AttributeMappingItem,
        eyes: AttributeMappingItem,
    }

    entry fun add_attribute(arg0: &MintingControl, arg1: &mut AttributeMapping, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg5)), 1);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<u8>>(&arg3) && 0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<u64>(&arg4), 0);
        while (!0x1::vector::is_empty<vector<u8>>(&arg2)) {
            let v0 = 0x1::vector::pop_back<vector<u8>>(&mut arg2);
            let v1 = &v0;
            let v2 = if (*v1 == b"background") {
                &mut arg1.background
            } else if (*v1 == b"beard") {
                &mut arg1.beard
            } else if (*v1 == b"body") {
                &mut arg1.body
            } else if (*v1 == b"eyes") {
                &mut arg1.eyes
            } else if (*v1 == b"hat") {
                &mut arg1.hat
            } else {
                &mut arg1.background
            };
            0x1::vector::push_back<u64>(&mut v2.probabilities, 0x1::vector::pop_back<u64>(&mut arg4));
            0x2::table::add<u64, vector<u8>>(&mut v2.id_to_value, 0x1::vector::length<u64>(&v2.probabilities) - 1, 0x1::vector::pop_back<vector<u8>>(&mut arg3));
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        0x1::vector::destroy_empty<vector<u8>>(arg3);
        0x1::vector::destroy_empty<u64>(arg4);
    }

    fun create_attribute(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : ManiacAttributeNft {
        0x1::vector::append<u8>(&mut arg1, b" Attribute");
        let v0 = 0x2::object::new(arg2);
        let v1 = b"https://metadata.coinfever.app/api/attribute/?id=";
        let v2 = 0x2::address::to_string(0x2::object::uid_to_address(&v0));
        0x1::vector::append<u8>(&mut v1, *0x1::string::as_bytes(&v2));
        ManiacAttributeNft{
            id          : v0,
            name        : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(v1),
            field_type  : 0x1::string::utf8(arg0),
            field_value : 0x1::string::utf8(arg1),
        }
    }

    public(friend) fun create_random_attribute(arg0: &AttributeMapping, arg1: vector<u8>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : ManiacAttributeNft {
        let v0 = get_random_attribute(arg0, arg1, arg2, arg3);
        create_attribute(arg1, v0, arg3)
    }

    public fun field_type(arg0: &ManiacAttributeNft) : &0x1::string::String {
        &arg0.field_type
    }

    public fun field_value(arg0: &ManiacAttributeNft) : &0x1::string::String {
        &arg0.field_value
    }

    public fun get_attribute(arg0: &AttributeMapping, arg1: vector<u8>, arg2: u64) : vector<u8> {
        let v0 = &arg1;
        if (*v0 == b"background") {
            *0x2::table::borrow<u64, vector<u8>>(&arg0.background.id_to_value, arg2)
        } else if (*v0 == b"beard") {
            *0x2::table::borrow<u64, vector<u8>>(&arg0.beard.id_to_value, arg2)
        } else if (*v0 == b"body") {
            *0x2::table::borrow<u64, vector<u8>>(&arg0.body.id_to_value, arg2)
        } else if (*v0 == b"eyes") {
            *0x2::table::borrow<u64, vector<u8>>(&arg0.eyes.id_to_value, arg2)
        } else if (*v0 == b"hat") {
            *0x2::table::borrow<u64, vector<u8>>(&arg0.hat.id_to_value, arg2)
        } else {
            b"None"
        }
    }

    fun get_random_attribute(arg0: &AttributeMapping, arg1: vector<u8>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = &arg1;
        let v1 = if (*v0 == b"background") {
            &arg0.background
        } else if (*v0 == b"beard") {
            &arg0.beard
        } else if (*v0 == b"body") {
            &arg0.body
        } else if (*v0 == b"eyes") {
            &arg0.eyes
        } else if (*v0 == b"hat") {
            &arg0.hat
        } else {
            &arg0.background
        };
        get_attribute(arg0, arg1, get_random_number(&v1.probabilities, arg2, arg3))
    }

    fun get_random_number(arg0: &vector<u64>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        let v2 = 0x2::random::new_generator(arg1, arg2);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(arg0)) {
            let v5 = v3 + *0x1::vector::borrow<u64>(arg0, v4);
            v3 = v5;
            if (0x2::random::generate_u64_in_range(&mut v2, 0, v0 - 1) < v5) {
                return v4
            };
            v4 = v4 + 1;
        };
        0
    }

    entry fun giveaway(arg0: &MintingControl, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg4)), 1);
        while (!0x1::vector::is_empty<address>(&arg3)) {
            0x2::transfer::public_transfer<ManiacAttributeNft>(create_attribute(arg1, arg2, arg4), 0x1::vector::pop_back<address>(&mut arg3));
        };
        0x1::vector::destroy_empty<address>(arg3);
    }

    fun init(arg0: MANIAC_ATTRIBUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CoinFever"));
        let v4 = 0x2::package::claim<MANIAC_ATTRIBUTE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ManiacAttributeNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<ManiacAttributeNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ManiacAttributeNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Admin{admin_address: 0x2::tx_context::sender(arg1)};
        let v7 = MintingControl{
            id    : 0x2::object::new(arg1),
            admin : v6,
        };
        0x2::transfer::share_object<MintingControl>(v7);
        let v8 = AttributeMappingItem{
            probabilities : vector[],
            id_to_value   : 0x2::table::new<u64, vector<u8>>(arg1),
        };
        let v9 = AttributeMappingItem{
            probabilities : vector[],
            id_to_value   : 0x2::table::new<u64, vector<u8>>(arg1),
        };
        let v10 = AttributeMappingItem{
            probabilities : vector[],
            id_to_value   : 0x2::table::new<u64, vector<u8>>(arg1),
        };
        let v11 = AttributeMappingItem{
            probabilities : vector[],
            id_to_value   : 0x2::table::new<u64, vector<u8>>(arg1),
        };
        let v12 = AttributeMappingItem{
            probabilities : vector[],
            id_to_value   : 0x2::table::new<u64, vector<u8>>(arg1),
        };
        let v13 = AttributeMapping{
            id         : 0x2::object::new(arg1),
            background : v8,
            body       : v9,
            hat        : v10,
            beard      : v11,
            eyes       : v12,
        };
        0x2::transfer::share_object<AttributeMapping>(v13);
    }

    fun is_admin(arg0: &MintingControl, arg1: address) : bool {
        arg0.admin.admin_address == arg1
    }

    // decompiled from Move bytecode v6
}

