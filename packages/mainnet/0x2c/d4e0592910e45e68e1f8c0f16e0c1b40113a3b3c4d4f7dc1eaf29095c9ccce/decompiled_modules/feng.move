module 0x2cd4e0592910e45e68e1f8c0f16e0c1b40113a3b3c4d4f7dc1eaf29095c9ccce::feng {
    struct FENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENG>(arg0, 9, b"FENG", b"Sui Mascot", b"Sui Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmaPTJxPt8ddxocCixn2MpRXnfZBGLQF62krpJjZrnXjk2"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FENG>>(v1);
        0x2::coin::mint_and_transfer<FENG>(&mut v2, 1000000000000000000, @0x1640fa3f2792ac7f761706f618fc0d9db22f604cf8d2a77d3a9373eedfc59ecd, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FENG>>(v2);
    }

    // decompiled from Move bytecode v6
}

