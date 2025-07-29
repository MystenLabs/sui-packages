module 0x84e9d75a26e0feb784296973a5fada1d56452b291522d383f1ca5b82e476e9cb::baby_ika {
    struct BABY_IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY_IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY_IKA>(arg0, 6, b"Baby IKA", b"Baby Ika Sui", b"Just a baby of IKA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigxnetxl2rzjr77xm3xwsczdtl66gjel22np452dacgxpghktcxpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY_IKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABY_IKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

