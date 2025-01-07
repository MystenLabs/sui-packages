module 0x4875dfcabe8cb5c5a81e7d0f281cd49fdf7daf9bb08ef217c7f98bc9fe9e003d::turbos {
    struct TURBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOS>(arg0, 9, b"TURBOS", b"Sui Turbo", b"Sui Nitro is a high-speed token on the Sui blockchain, delivering fast transactions, low fees, and superior scalability. Optimized for decentralized apps, Sui Nitro powers next-level performance and reliability, making it the go-to choice for seamless blockchain experiences.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1680322010650677248/3B0n4nuE.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TURBOS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

