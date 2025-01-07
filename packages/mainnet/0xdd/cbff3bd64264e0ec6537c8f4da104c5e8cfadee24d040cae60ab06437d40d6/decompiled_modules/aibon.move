module 0xddcbff3bd64264e0ec6537c8f4da104c5e8cfadee24d040cae60ab06437d40d6::aibon {
    struct AIBON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBON>(arg0, 9, b"AIBON", b"Lem Aibon", b"Its just a glue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d54c5cba-6ed6-47af-aa55-68916ea56b66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIBON>>(v1);
    }

    // decompiled from Move bytecode v6
}

