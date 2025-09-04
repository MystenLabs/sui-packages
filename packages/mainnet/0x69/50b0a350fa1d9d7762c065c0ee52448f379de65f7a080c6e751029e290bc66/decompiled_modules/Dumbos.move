module 0x6950b0a350fa1d9d7762c065c0ee52448f379de65f7a080c6e751029e290bc66::Dumbos {
    struct DUMBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBOS>(arg0, 9, b"DUMBOS", b"Dumbos", b"tweedle dumb and tweedle dee. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz985UhXcAA-cLj?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMBOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

