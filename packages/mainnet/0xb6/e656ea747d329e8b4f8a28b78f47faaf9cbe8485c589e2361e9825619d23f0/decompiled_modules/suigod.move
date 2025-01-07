module 0xb6e656ea747d329e8b4f8a28b78f47faaf9cbe8485c589e2361e9825619d23f0::suigod {
    struct SUIGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOD>(arg0, 9, b"SUIGOD", b"GOD OF MEMES", b"SUI blockchain is the fastest growing blockchain for memes token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a8865d6e98a70254d54e8d9303696724blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

