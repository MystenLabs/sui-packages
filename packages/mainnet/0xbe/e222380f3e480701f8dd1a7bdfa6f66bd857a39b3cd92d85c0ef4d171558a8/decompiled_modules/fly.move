module 0xbee222380f3e480701f8dd1a7bdfa6f66bd857a39b3cd92d85c0ef4d171558a8::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 6, b"FLY", b"FlyFi", x"466c79466920206c696b6520446546692c2062757420776974682077696e67732e0a506f77657265642062792077696e67732e200a4675656c6564206279206d656d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_3_1_1ef3606fb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

