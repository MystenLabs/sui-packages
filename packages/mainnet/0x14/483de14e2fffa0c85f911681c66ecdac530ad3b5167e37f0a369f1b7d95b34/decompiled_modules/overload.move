module 0x14483de14e2fffa0c85f911681c66ecdac530ad3b5167e37f0a369f1b7d95b34::overload {
    struct OVERLOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVERLOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OVERLOAD>(arg0, 6, b"OVERLOAD", b"diwata paris by SuiAI", b"paris over diwata", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/qweqwe_b0775a8c5d.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OVERLOAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVERLOAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

