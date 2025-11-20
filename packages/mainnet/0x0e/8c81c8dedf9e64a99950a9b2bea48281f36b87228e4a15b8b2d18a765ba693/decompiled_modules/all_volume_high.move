module 0xe8c81c8dedf9e64a99950a9b2bea48281f36b87228e4a15b8b2d18a765ba693::all_volume_high {
    struct ALL_VOLUME_HIGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALL_VOLUME_HIGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALL_VOLUME_HIGH>(arg0, 6, b"AVH", b"All Volume High", b"All Volume High is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALL_VOLUME_HIGH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALL_VOLUME_HIGH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

