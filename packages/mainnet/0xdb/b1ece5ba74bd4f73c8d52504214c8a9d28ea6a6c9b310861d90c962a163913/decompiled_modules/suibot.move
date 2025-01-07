module 0xdbb1ece5ba74bd4f73c8d52504214c8a9d28ea6a6c9b310861d90c962a163913::suibot {
    struct SUIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOT>(arg0, 9, b"SUIBOT", b"Sui Sniper Bot", b"SUI SNIPER BOT : https://t.me/SuiSniperBot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmSzEDkPZe1Ap8YgvqiquPZ2B7pzccLHfBz4pt9DK7BtR8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBOT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

