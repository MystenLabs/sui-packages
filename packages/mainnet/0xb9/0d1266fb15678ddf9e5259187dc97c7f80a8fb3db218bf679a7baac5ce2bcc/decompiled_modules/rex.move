module 0xb90d1266fb15678ddf9e5259187dc97c7f80a8fb3db218bf679a7baac5ce2bcc::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"suirex", x"e2809c73752d72c99b6b73e2809d2e20536f6d657468696e672062696720616e6420626c756520697320636f6d696e67206578636c75736976656c7920746f200a547572626f732e2049e280996d205265782c207765e28099726520616c6c20526578e280a62e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988233435.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

