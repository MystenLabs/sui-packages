module 0x7eaac8395f471c0904a4dedd35ba8967c248e18f42015c2d7aa729c91715eeed::jk {
    struct JK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JK>(arg0, 6, b"JK", b"Jack", b"None", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1761277532726.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

