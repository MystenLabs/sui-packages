module 0x686460d903b4ed33c2e85a6fbb881e92c958e96120a5bf59da12d525e078c678::sui_miner {
    struct SUI_MINER has drop {
        dummy_field: bool,
    }

    struct Attribute has copy, drop, store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct SuiMiner has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: vector<Attribute>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun attributes(arg0: &SuiMiner) : &vector<Attribute> {
        &arg0.attributes
    }

    public entry fun burn(arg0: SuiMiner, arg1: &mut 0x2::tx_context::TxContext) {
        let SuiMiner {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SuiMiner) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SuiMiner) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: SUI_MINER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SUI_MINER>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://enchantedminers.com/"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Enchanted Miners"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes}"));
        let v6 = 0x2::display::new_with_fields<SuiMiner>(&v1, v2, v4, arg1);
        0x2::display::update_version<SuiMiner>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<SuiMiner>(&v1, arg1);
        let v9 = v8;
        let v10 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<SuiMiner>(&mut v10, &v9, 500, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<SuiMiner>(&mut v10, &v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuiMiner>>(v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuiMiner>>(v9, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SuiMiner>>(v6, v0);
        let v11 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v11, v0);
    }

    public entry fun mint(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 0);
        let v0 = 0x1::vector::empty<Attribute>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            let v2 = Attribute{
                trait_type : *0x1::vector::borrow<0x1::string::String>(&arg4, v1),
                value      : *0x1::vector::borrow<0x1::string::String>(&arg5, v1),
            };
            0x1::vector::push_back<Attribute>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = SuiMiner{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            attributes  : v0,
        };
        0x2::transfer::public_transfer<SuiMiner>(v3, arg6);
    }

    public fun name(arg0: &SuiMiner) : &0x1::string::String {
        &arg0.name
    }

    public fun trait_type(arg0: &Attribute) : &0x1::string::String {
        &arg0.trait_type
    }

    public fun value(arg0: &Attribute) : &0x1::string::String {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

