module 0x90528ea5621c342a8e1006b41da005380fa3784224a0a236ec4e4e954f1a9f7e::justest {
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

