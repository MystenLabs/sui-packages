module 0x24eb23e57fdb7e958a41cee631f15f435c1aaf6fa95d7ef901af93db31edeff8::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 6, b"LAMBO", b"LamboLulz", x"e2809c46726f6d204d656d657320746f204d616368696e657321e2809d0a4c616d626f4c756c7a2028244c414d424f2920697320666f72206576657279206d656d652077617272696f722077686f20647265616d73206f66206d6f6f6e696e672074686569722077617920746f2061204c616d626f726768696e692e6f6374616e6520616d626974696f6e2c4275636b6c65207570e280946974e280997320676f696e6720746f20626520612068696c6172696f75732072696465210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731040121644.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

