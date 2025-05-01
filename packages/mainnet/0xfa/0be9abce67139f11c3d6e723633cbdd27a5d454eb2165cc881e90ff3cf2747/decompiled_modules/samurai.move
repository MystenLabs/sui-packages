module 0xfa0be9abce67139f11c3d6e723633cbdd27a5d454eb2165cc881e90ff3cf2747::samurai {
    struct SAMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMURAI>(arg0, 6, b"SamUraI", b"SamUeaI on SUI", x"2053616d7572616920546f6b656e202853414d5552414929200a41204d656d6520436f696e2077697468204469736369706c696e652c20486f6e6f722c20616e6420507572706f73650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d447a1f8599511ee964ae6d39d9a42a4_upscaled_1_8e9f739071.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

