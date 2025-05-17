module 0x4ca2b0836e5400992434f657468d65a1af6172371599d56ad1fdd1511777c0f3::kap {
    struct KAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAP>(arg0, 6, b"KAP", b"kapuchi", b"kapipiiiisisiiss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwjts5leqfnqmc7ompvqlqfi7rtsax4z7cpzsaibvt5gurgeauoq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

