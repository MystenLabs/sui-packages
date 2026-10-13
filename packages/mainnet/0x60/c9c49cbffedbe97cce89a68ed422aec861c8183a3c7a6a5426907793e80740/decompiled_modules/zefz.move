module 0x60c9c49cbffedbe97cce89a68ed422aec861c8183a3c7a6a5426907793e80740::zefz {
    struct ZEFZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEFZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nqqsgs";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dazsa";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<ZEFZ>(arg0, 6, b"ZEFZ", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/IydBZAtQQ7oxYi6V")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEFZ>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEFZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

