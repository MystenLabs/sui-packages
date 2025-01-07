module 0x79df4975b00721d20a903714b971d3f375c9b99b2e34290b881f41e4b97ebd5a::rare {
    struct Rare has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct TransferCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct RARE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: &TransferCap<RARE>, arg1: Rare, arg2: address) {
        0x2::transfer::transfer<Rare>(arg1, arg2);
    }

    fun init(arg0: RARE, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Rare NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://chirptoken.io/"));
        let v4 = 0x2::package::claim<RARE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Rare>(&v4, v0, v2, arg1);
        0x2::display::update_version<Rare>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = TransferCap<RARE>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TransferCap<RARE>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Rare>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &0x2::package::Publisher, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Rare>(arg0), 0);
        assert!(0x2::package::from_module<Rare>(arg0), 0);
        assert!(arg1 > 0, 1);
        while (arg1 > 0) {
            let v0 = Rare{
                id        : 0x2::object::new(arg5),
                name      : arg2,
                image_url : arg3,
            };
            0x2::transfer::transfer<Rare>(v0, arg4);
            arg1 = arg1 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

