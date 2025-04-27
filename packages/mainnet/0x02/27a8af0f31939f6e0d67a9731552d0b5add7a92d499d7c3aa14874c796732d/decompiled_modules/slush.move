module 0x227a8af0f31939f6e0d67a9731552d0b5add7a92d499d7c3aa14874c796732d::slush {
    struct SLUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUSH>(arg0, 9, b"SLUSH", b"Slush Wallet", b"Your Sui super app.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1915842075993714688/LZMuFMKt_400x400.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLUSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLUSH>>(0x2::coin::mint<SLUSH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SLUSH>>(v2);
    }

    // decompiled from Move bytecode v6
}

