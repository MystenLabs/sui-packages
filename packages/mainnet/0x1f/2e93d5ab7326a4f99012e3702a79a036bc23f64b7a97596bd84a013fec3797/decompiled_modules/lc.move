module 0x1f2e93d5ab7326a4f99012e3702a79a036bc23f64b7a97596bd84a013fec3797::lc {
    struct LC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LC>(arg0, 6, b"LC", b"Liquidation Call", b"Stop Trading Believe In Something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0816_dd6f57b59b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LC>>(v1);
    }

    // decompiled from Move bytecode v6
}

