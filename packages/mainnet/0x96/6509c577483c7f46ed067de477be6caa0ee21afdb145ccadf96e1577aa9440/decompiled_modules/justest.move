module 0x966509c577483c7f46ed067de477be6caa0ee21afdb145ccadf96e1577aa9440::justest {
    struct JUSTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTEST>(arg0, 6, b"jusTest", b"Test", b"This is just a test, don't buy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034220_a3e8ee7360.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

