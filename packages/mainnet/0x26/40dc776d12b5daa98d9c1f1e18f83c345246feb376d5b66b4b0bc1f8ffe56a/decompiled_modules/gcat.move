module 0x2640dc776d12b5daa98d9c1f1e18f83c345246feb376d5b66b4b0bc1f8ffe56a::gcat {
    struct GCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCAT>(arg0, 6, b"GCAT", b"GURU CAT", b"GURU of cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730446417311.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

