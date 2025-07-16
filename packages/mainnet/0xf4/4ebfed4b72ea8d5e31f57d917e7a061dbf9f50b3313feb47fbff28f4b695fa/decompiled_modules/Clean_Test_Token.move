module 0xf44ebfed4b72ea8d5e31f57d917e7a061dbf9f50b3313feb47fbff28f4b695fa::Clean_Test_Token {
    struct CLEAN_TEST_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLEAN_TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLEAN_TEST_TOKEN>(arg0, 9, b"CTT", b"Clean Test Token", b"Testing clean output", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLEAN_TEST_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLEAN_TEST_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

