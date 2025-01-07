module 0x7f6d06b51b41f8e921333618dd928c1084c9d218d213eeb81a4807e99922a3f3::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 6, b"S", b"SCoin", x"436c61737369632064726177696e67207765207573656420746f206472617720696e207363686f6f6c207768656e207765207765726520746f6f2062757379206265696e6720617574697374696320696e20636c6173730a0a54686520756e6976657273616c2053", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_2_f9a0882b8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

