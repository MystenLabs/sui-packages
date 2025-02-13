module 0x5ddcda699a8e5adc1ade2540821884134364eb4ebc9d59c99abc0b218a6d9a84::chems {
    struct CHEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEMS>(arg0, 9, b"CHEMS", b"CHEMS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_EavwKERmVAm-8nDKnd8PrCO1sXhyVpLyPA&s"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

