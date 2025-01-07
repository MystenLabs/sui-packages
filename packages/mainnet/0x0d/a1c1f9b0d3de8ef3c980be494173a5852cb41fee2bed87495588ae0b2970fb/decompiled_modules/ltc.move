module 0xda1c1f9b0d3de8ef3c980be494173a5852cb41fee2bed87495588ae0b2970fb::ltc {
    struct LTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTC>(arg0, 8, b"LTC", b"Wrapped Litecoin", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LTC>>(v0);
    }

    // decompiled from Move bytecode v6
}

