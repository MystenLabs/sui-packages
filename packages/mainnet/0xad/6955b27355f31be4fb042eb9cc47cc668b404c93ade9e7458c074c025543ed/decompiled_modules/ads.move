module 0xad6955b27355f31be4fb042eb9cc47cc668b404c93ade9e7458c074c025543ed::ads {
    struct ADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADS>(arg0, 9, b"ADS", b"AIRDROPS", b"$ADS _ a memes token in love and support of airdrops , cherished by all the airdrop hunters .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2562bce8-9a9a-4eee-8880-ba5b2bf69737-1000006578.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADS>>(v1);
    }

    // decompiled from Move bytecode v6
}

