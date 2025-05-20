module 0x1c3e8d13100d800bad0fbbd68e3309bb438d98deb77f8a94c49b9f02e1dcb410::goosebucks {
    struct GOOSEBUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSEBUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSEBUCKS>(arg0, 9, b"GOOSEBUCKS", b"GooseBucks", b"Honk for profits! GooseBucks waddles in with silly energy, honking up noise and golden eggs for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreidfbpzgdxkgbxcfybqeqnyylp5v5u7lvj35hxf3srn5ovbgrt4cty")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOOSEBUCKS>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSEBUCKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOSEBUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

