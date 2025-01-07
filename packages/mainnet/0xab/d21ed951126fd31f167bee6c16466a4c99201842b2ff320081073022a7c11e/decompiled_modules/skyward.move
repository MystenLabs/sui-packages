module 0xabd21ed951126fd31f167bee6c16466a4c99201842b2ff320081073022a7c11e::skyward {
    struct Skyward has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
    }

    struct TransferCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct SKYWARD has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: &TransferCap<SKYWARD>, arg1: Skyward, arg2: address) {
        0x2::transfer::transfer<Skyward>(arg1, arg2);
    }

    fun init(arg0: SKYWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::package::claim<SKYWARD>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Skyward>(&v4, v0, v2, arg1);
        0x2::display::update_version<Skyward>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = TransferCap<SKYWARD>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TransferCap<SKYWARD>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Skyward>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &0x2::package::Publisher, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Skyward>(arg0), 0);
        assert!(0x2::package::from_module<Skyward>(arg0), 0);
        assert!(arg1 > 0, 1);
        while (arg1 > 0) {
            let v0 = Skyward{
                id          : 0x2::object::new(arg7),
                name        : arg2,
                description : arg4,
                image_url   : arg3,
                project_url : arg5,
            };
            0x2::transfer::transfer<Skyward>(v0, arg6);
            arg1 = arg1 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

