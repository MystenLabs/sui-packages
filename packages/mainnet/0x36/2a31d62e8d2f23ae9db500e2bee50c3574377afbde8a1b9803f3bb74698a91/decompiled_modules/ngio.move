module 0x362a31d62e8d2f23ae9db500e2bee50c3574377afbde8a1b9803f3bb74698a91::ngio {
    struct NGIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGIO>(arg0, 6, b"NGIO", b"ngio", b"https://x.com/0xNgio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738338425420.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

