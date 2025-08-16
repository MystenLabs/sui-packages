module 0x767aed3a872cd19a19a4e48f270ed068f9e44e2890feec84b9c43a262b7f0dd7::grid_on_chain {
    struct GRID_ON_CHAIN has drop {
        dummy_field: bool,
    }

    struct GridOnChain has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img: 0x1::string::String,
    }

    fun init(arg0: GRID_ON_CHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GRID_ON_CHAIN>(arg0, arg1);
        let v1 = 0x2::display::new<GridOnChain>(&v0, arg1);
        0x2::display::add<GridOnChain>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"GRID ON CHAIN SOCSC"));
        0x2::display::add<GridOnChain>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"GRIDY GRID FROM SOCSC FUTMINNA"));
        0x2::display::add<GridOnChain>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{img}"));
        0x2::display::add<GridOnChain>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"SOCSC FUTMINNA"));
        0x2::display::update_version<GridOnChain>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GridOnChain>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = GridOnChain{
            id   : 0x2::object::new(arg3),
            name : arg0,
            img  : arg1,
        };
        0x2::transfer::public_transfer<GridOnChain>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

