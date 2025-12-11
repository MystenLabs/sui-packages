module 0x13aac8806152c5877fdfe93c424f877dbe0bbf88b2210c69045aa5c140404a56::sydai {
    struct SYDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYDAI>(arg0, 9, b"SYDAI", b"SydAi", b"SYDAI combines AI intelligence with SUI speed. A token built for automated systems, smart agents, and seamless machine-powered interaction across the decentralized web.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidkfwjtuuqz2fnaits2szazkywxx7s5iffc5lpp6hervo634ujtpy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SYDAI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYDAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

