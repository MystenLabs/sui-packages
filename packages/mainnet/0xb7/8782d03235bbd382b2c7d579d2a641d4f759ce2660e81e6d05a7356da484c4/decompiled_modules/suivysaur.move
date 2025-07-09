module 0xb78782d03235bbd382b2c7d579d2a641d4f759ce2660e81e6d05a7356da484c4::suivysaur {
    struct SUIVYSAUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVYSAUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVYSAUR>(arg0, 9, b"IVYSUI", b"Suivysaur", b"A lizard with leafy wings, tail wrapped in Sui vines, flowers blooming Sui droplets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreigdox6xj5jhuisitr22uassas5y7lnw6hceoozuv4lrivobg2epoi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIVYSAUR>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVYSAUR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVYSAUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

