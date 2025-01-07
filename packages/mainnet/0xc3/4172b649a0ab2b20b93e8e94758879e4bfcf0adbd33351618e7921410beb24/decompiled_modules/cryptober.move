module 0xc34172b649a0ab2b20b93e8e94758879e4bfcf0adbd33351618e7921410beb24::cryptober {
    struct CRYPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTOBER>(arg0, 6, b"CRYPTOBER", b"Cryptober on SUI", b"As Cryptober ignites on the SUI Network, the crypto markets blaze with green candles, setting the stage for explosive growth. Fueled by Octobers momentum, this is the month where fortunes are made, and the blockchain roars with bullish energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_18_23_59_c9547367ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

