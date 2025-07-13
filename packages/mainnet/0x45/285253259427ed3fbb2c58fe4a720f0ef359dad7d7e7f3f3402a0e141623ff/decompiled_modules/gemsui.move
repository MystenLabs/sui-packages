module 0x45285253259427ed3fbb2c58fe4a720f0ef359dad7d7e7f3f3402a0e141623ff::gemsui {
    struct GEMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMSUI>(arg0, 9, b"GEMSUI", b"Gemsui", b"A crystalline gem creature with faceted Sui patterns, refracting light into rainbow meme sparkles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreid6osgjatvcegnlxtkxp7n4v5rkozc3dyheioh736bo5u3ikpfzbq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GEMSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

