module 0xec45bb5a9803e1127d9c829a931d296e3f0ccfe7172b44b52f905efb13297fab::souyy {
    struct SOUYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUYY>(arg0, 9, b"SOUYY", b"Soyu", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4f3483a438020c9c6b8e9739dcfaac5eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUYY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUYY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

