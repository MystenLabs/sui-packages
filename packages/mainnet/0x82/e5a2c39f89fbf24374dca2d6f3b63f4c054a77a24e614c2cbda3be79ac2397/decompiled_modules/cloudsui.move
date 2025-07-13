module 0x82e5a2c39f89fbf24374dca2d6f3b63f4c054a77a24e614c2cbda3be79ac2397::cloudsui {
    struct CLOUDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUDSUI>(arg0, 9, b"CLDSUI", b"Cloudsui", b"A fluffy white cloud with a face, raining Sui coins instead of water, floating with a rainbow trail.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreidmmvcejzl3n4oqpnkoekudwatx4ggwwmmr3mfqrp7wnotk3gplkm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLOUDSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUDSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOUDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

