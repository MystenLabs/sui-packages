module 0x5fd2794f1b97b7a1326a24716913a9450f6218092a80d2c533f9e82f3a88d77b::supunk {
    struct SUPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPUNK>(arg0, 9, b"SUPUNK", b"Suipunkz", b"In a tech-driven future, the Suipunkz use the Sui Protocol to break free from corporate control and create a decentralized, fair digital world for all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842998199339962368/uHJA5lVy.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUPUNK>(&mut v2, 1200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPUNK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

