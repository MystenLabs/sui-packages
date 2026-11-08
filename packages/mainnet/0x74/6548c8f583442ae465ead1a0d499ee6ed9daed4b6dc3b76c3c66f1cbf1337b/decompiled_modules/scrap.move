module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap {
    struct Scrap has store, key {
        id: 0x2::object::UID,
        units: u64,
    }

    public fun destroy_empty(arg0: Scrap) {
        let Scrap {
            id    : v0,
            units : v1,
        } = arg0;
        assert!(v1 == 0, 491);
        0x2::object::delete(v0);
    }

    public(friend) fun burn(arg0: Scrap) : u64 {
        let Scrap {
            id    : v0,
            units : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    entry fun create_display(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1), 493);
        let v0 = 0x2::object::id<0x2::display_registry::DisplayRegistry>(arg2);
        assert!(0x2::object::id_to_address(&v0) == @0xd, 492);
        let (v1, v2) = 0x2::display_registry::new<Scrap>(arg2, 0x1::internal::permit<Scrap>(), arg3);
        let v3 = v2;
        let v4 = v1;
        let v5 = fields();
        let v6 = keys();
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::string::String>(&v6)) {
            0x2::display_registry::set<Scrap>(&mut v4, &v3, *0x1::vector::borrow<0x1::string::String>(&v6, v7), *0x1::vector::borrow<0x1::string::String>(&v5, v7));
            v7 = v7 + 1;
        };
        0x2::display_registry::share<Scrap>(v4);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Scrap>>(v3, 0x2::tx_context::sender(arg3));
    }

    fun fields() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(x"536372617020c397207b756e6974737d"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"What the dig leaves under the MORTEM graves. The forge mends shovels with it."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://mortem.alienz.tech/assets/shovels/v1/scrap.webp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://mortem.alienz.tech/assets/shovels/v1/scrap.webp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://mortem.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"PulseSinister & Sudcero"));
        v0
    }

    public fun join(arg0: &mut Scrap, arg1: Scrap) {
        let Scrap {
            id    : v0,
            units : v1,
        } = arg1;
        0x2::object::delete(v0);
        arg0.units = arg0.units + v1;
    }

    fun keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        v0
    }

    public(friend) fun mint(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Scrap {
        Scrap{
            id    : 0x2::object::new(arg1),
            units : arg0,
        }
    }

    public fun split(arg0: &mut Scrap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Scrap {
        assert!(arg1 > 0 && arg1 < arg0.units, 490);
        arg0.units = arg0.units - arg1;
        Scrap{
            id    : 0x2::object::new(arg2),
            units : arg1,
        }
    }

    public fun units(arg0: &Scrap) : u64 {
        arg0.units
    }

    // decompiled from Move bytecode v7
}

