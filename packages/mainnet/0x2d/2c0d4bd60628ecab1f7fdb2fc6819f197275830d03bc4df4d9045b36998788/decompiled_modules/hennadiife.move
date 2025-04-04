module 0x2d2c0d4bd60628ecab1f7fdb2fc6819f197275830d03bc4df4d9045b36998788::hennadiife {
    struct HENNADIIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENNADIIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENNADIIFE>(arg0, 9, b"Hennadiife", b"hennadii", b"Hennadii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b1f995516b93bbc3cb1a62663a4ccbc4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HENNADIIFE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENNADIIFE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

