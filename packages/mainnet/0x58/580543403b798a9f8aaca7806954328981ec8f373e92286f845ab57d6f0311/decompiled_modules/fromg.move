module 0x58580543403b798a9f8aaca7806954328981ec8f373e92286f845ab57d6f0311::fromg {
    struct FROMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROMG>(arg0, 6, b"FROMG", b"Moon Frog", b"Rocket to moon or pluto?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731009999063.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROMG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROMG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

