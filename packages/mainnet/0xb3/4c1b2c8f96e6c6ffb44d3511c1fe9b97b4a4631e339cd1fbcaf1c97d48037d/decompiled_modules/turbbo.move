module 0xb34c1b2c8f96e6c6ffb44d3511c1fe9b97b4a4631e339cd1fbcaf1c97d48037d::turbbo {
    struct TURBBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBBO>(arg0, 9, b"TURBBO", b"Baby Turbo", b"Baby Turbo is a fast and agile token built on the Sui blockchain, designed for quick transactions and low fees, with a fresh, community-focused approach. It symbolizes speed and innovation in the DeFi space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1680322010650677248/3B0n4nuE.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TURBBO>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

