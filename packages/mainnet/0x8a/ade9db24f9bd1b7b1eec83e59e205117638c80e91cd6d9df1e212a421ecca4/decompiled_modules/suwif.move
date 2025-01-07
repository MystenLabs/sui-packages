module 0x8aade9db24f9bd1b7b1eec83e59e205117638c80e91cd6d9df1e212a421ecca4::suwif {
    struct SUWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWIF>(arg0, 9, b"SUWIF", b"Suwifhat", b"SuwiFhat is a versatile digital token on the SUI blockchain, focused on driving financial innovation and wealth creation. It powers decentralized finance (DeFi) platforms and promotes community-driven growth with advanced blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1546980946804703236/89Ee5YiD.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUWIF>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

