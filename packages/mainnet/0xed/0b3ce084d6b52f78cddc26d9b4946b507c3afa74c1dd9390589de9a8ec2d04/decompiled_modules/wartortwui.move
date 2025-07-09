module 0xed0b3ce084d6b52f78cddc26d9b4946b507c3afa74c1dd9390589de9a8ec2d04::wartortwui {
    struct WARTORTWUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARTORTWUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARTORTWUI>(arg0, 9, b"WARTW", b"Wartortwui", b"A blue, armored turtle with blasters spouting Sui-shaped water, surfing a golden Sui coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WARTORTWUI>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARTORTWUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARTORTWUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

