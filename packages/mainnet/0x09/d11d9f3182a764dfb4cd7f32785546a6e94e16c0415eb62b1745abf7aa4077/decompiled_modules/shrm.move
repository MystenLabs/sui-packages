module 0x9d11d9f3182a764dfb4cd7f32785546a6e94e16c0415eb62b1745abf7aa4077::shrm {
    struct SHRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRM>(arg0, 6, b"SHRM", b"MetaShrooms", b"A whimsical token inspired by the idea of magical mushrooms in the metaverse where you can  \"Grow your portfolio with a touch of magic.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736041314140.14")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

