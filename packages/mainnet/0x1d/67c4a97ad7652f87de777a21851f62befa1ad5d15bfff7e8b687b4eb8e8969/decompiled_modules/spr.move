module 0x1d67c4a97ad7652f87de777a21851f62befa1ad5d15bfff7e8b687b4eb8e8969::spr {
    struct SPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPR>(arg0, 6, b"SPR", b"SUIPERIOR", b"Suiperior sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif46fi2fro4s3apfsaga7hmw2xeqssvyswjr6i67plpewredmkkey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

