module 0xf8866511bb59233c741c04f9f57757146a9a974e3aa422bf969e6ae9f6c20cca::tismer {
    struct TISMER has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Tismer has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun edit(arg0: &AdminCap, arg1: &mut Tismer, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg1.name = arg2;
        arg1.image_url = arg3;
    }

    fun init(arg0: TISMER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TISMER>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::display::new_with_fields<Tismer>(&v0, v1, v3, arg1);
        0x2::display::update_version<Tismer>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Tismer>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, @0xfcd5f2eee4ca6d81d49c85a1669503b7fc8e641b406fe7cdb696a67ef861492c);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v8, @0x8308219972c32d2bcc50186da0568059f36ae12360739c963dc097c5a0929449);
    }

    public fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Tismer {
        Tismer{
            id        : 0x2::object::new(arg3),
            name      : arg1,
            image_url : arg2,
        }
    }

    public entry fun mint_and_transfer(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Tismer>(mint(arg0, arg1, arg2, arg4), arg3);
    }

    public fun new_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

