module 0x328489078017caf9858a9bfa47b872049d588bf2802032dcda0ac3ff16cd0fe::snek {
    struct SNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEK>(arg0, 9, b"SNEK", b"Sui Snek", x"6974e2809973206120736e656b2c2077652062757920686f6c6420616e6420766962652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmXcxABkGjASaBTqZ4C8MkyegNdm8PxvSEzcNNdTttS2Gr?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNEK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

