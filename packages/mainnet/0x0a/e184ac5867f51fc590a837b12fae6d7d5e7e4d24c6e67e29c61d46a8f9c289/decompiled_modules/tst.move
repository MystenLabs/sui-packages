module 0xae184ac5867f51fc590a837b12fae6d7d5e7e4d24c6e67e29c61d46a8f9c289::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"test ", b"dont buy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755858578515.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

