module 0x558abfbe6ebf4210ad912aeab5eca62bbd7ab9d2c1ff7d8d994a1b839819f445::magc {
    struct MAGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGC>(arg0, 9, b"MAGC", b"Magic Coin", b"We're the Magic Coin DAO, harnessing the power of decentralized finance to bring magic to the world of crypto. We're building the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JawS7fp.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGC>(&mut v2, 110000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

