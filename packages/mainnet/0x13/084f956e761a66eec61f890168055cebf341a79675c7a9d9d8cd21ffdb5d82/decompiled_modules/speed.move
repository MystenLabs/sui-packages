module 0x13084f956e761a66eec61f890168055cebf341a79675c7a9d9d8cd21ffdb5d82::speed {
    struct SPEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEED>(arg0, 6, b"SPEED", b"SPEED TURTLE", b"SPEED IS TURTLE ON SUI, TURTLE BE FASTEN TO THE Moooooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3847_0b57c3fc25.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

