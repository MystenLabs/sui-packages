module 0xec58882a340f95e2093009944e2f9f41b021d33fc6d4282ab6266540572ab400::ls {
    struct LS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LS>(arg0, 6, b"LS", b"lock snipe", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreianiqo4fm6ugdnf2z6pizpxkjgfitpuvqp6wx4bln43t6njabxe6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

