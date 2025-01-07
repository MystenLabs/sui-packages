module 0x6c9bf78ba8bffddc7d973a4723d65a616c08eb8f24e30b3ea722538574bf4f50::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 9, b"Dog", x"44446f67f09f9095", b"Ddog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2Vkm2octBcWmTfvZ5iReQNRpADAtQjBmGm9UgcsXfy45.png?size=lg&key=aa15c0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

