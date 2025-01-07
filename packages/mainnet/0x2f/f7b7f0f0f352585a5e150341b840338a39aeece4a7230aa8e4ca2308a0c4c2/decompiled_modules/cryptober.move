module 0x2ff7b7f0f0f352585a5e150341b840338a39aeece4a7230aa8e4ca2308a0c4c2::cryptober {
    struct CRYPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTOBER>(arg0, 6, b"Cryptober", b"CRYPTOBER", b"As Cryptober ignites on the SUI Network, the crypto markets blaze with green candles, setting the stage for explosive growth. Fueled by Octobers momentum, this is the month where fortunes are made, and the blockchain roars with bullish energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_01_44_39_54b53ad1f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

