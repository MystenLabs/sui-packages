module 0x470e0e6c785b55d18dadbdf0a4b544902dcd0e91ccddbb69697f61996e49f965::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"Chill", b"Chill dude ", b"Just chilling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731513619634.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

