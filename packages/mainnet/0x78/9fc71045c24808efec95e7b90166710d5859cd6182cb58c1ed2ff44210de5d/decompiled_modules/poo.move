module 0x789fc71045c24808efec95e7b90166710d5859cd6182cb58c1ed2ff44210de5d::poo {
    struct POO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POO>(arg0, 6, b"Poo", b"PooSui", b"$POO is coming to shake up the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif4e7ncj5zo2mvlrxkf2nq7llykvkkg336stevp5lh4it5p3wdnwm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

