module 0x830c310b245ea14aed82df12c489cb5d95175372344b72ca56aa9bda6065ff6a::dracsui {
    struct DRACSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRACSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRACSUI>(arg0, 9, b"DRASUI", b"Dracsui", b"A sleek, dragonfly-like beast with holographic Sui wings, streaking through meme space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRACSUI>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRACSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

