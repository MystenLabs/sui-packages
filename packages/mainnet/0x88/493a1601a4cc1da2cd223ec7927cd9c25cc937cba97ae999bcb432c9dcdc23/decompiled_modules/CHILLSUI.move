module 0x88493a1601a4cc1da2cd223ec7927cd9c25cc937cba97ae999bcb432c9dcdc23::CHILLSUI {
    struct CHILLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSUI>(arg0, 9, b"CHILLSUI", b"CHILLSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLSUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLSUI>>(0x2::coin::mint<CHILLSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

