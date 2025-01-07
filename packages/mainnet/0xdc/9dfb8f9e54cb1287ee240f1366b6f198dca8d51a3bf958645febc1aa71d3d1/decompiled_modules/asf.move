module 0xdc9dfb8f9e54cb1287ee240f1366b6f198dca8d51a3bf958645febc1aa71d3d1::asf {
    struct ASF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASF>(arg0, 6, b"AsF", b"AssFace", b"A memecoin with intuit dominate de world of memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733009431251.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

