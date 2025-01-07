module 0xe0dc396e8564e316f8ec626289e19e2adb1e705f5aaec8ee232b559191de44ec::geous {
    struct GEOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEOUS>(arg0, 9, b"GeouS", b"GeousTrader", b"Geous's community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1714b12c8afd7c6a0700fb382aca0d6fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEOUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEOUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

