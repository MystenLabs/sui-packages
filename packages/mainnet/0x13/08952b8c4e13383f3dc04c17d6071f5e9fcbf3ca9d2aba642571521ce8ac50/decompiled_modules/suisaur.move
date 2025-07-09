module 0x1308952b8c4e13383f3dc04c17d6071f5e9fcbf3ca9d2aba642571521ce8ac50::suisaur {
    struct SUISAUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAUR>(arg0, 9, b"SUISR", b"Suisaur", b"A chunky, leaf-backed beast snoozing on a mountain of Sui tokens, with vines that spell SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISAUR>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAUR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

