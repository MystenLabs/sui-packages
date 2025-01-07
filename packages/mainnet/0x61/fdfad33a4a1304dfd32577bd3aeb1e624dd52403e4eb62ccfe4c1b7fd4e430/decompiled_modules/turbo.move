module 0x61fdfad33a4a1304dfd32577bd3aeb1e624dd52403e4eb62ccfe4c1b7fd4e430::turbo {
    struct TURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBO>(arg0, 9, b"TURBO", b"Turbo", b"TURBO is the first AI-Generated Meme Coin, launched with just a $69 budget. It stands for excellence in Web3 innovation. 100% community-owned.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1757480296025329664/diUSDZoR_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TURBO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

