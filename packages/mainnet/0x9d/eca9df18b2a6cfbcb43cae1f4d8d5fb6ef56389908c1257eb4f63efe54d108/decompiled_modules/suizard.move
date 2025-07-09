module 0x9deca9df18b2a6cfbcb43cae1f4d8d5fb6ef56389908c1257eb4f63efe54d108::suizard {
    struct SUIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZARD>(arg0, 9, b"SUIZD", b"Suizard", b"A fiery dragon with a shimmering Sui coin for a belly, its flame tail shapes into a dripping Sui droplet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIZARD>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZARD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

