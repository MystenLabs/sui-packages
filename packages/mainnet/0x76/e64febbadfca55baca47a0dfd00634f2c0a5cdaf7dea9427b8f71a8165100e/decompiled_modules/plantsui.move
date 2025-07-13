module 0x76e64febbadfca55baca47a0dfd00634f2c0a5cdaf7dea9427b8f71a8165100e::plantsui {
    struct PLANTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANTSUI>(arg0, 9, b"PLTSUI", b"Plantsui", b"A happy succulent in a pot, leaves shaped like Sui droplets, wearing tiny sunglasses and vibing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreihokip7x7dxu5tlw5nq2aepouc4hclfna2lnvl3gnvhu6nf6nlz2a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLANTSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

