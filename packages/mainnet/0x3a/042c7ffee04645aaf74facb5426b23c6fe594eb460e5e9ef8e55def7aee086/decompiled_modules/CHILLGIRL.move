module 0x3a042c7ffee04645aaf74facb5426b23c6fe594eb460e5e9ef8e55def7aee086::CHILLGIRL {
    struct CHILLGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGIRL>(arg0, 9, b"CHILLGIRL", b"CHILLGIRL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGIRL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLGIRL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLGIRL>>(0x2::coin::mint<CHILLGIRL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

