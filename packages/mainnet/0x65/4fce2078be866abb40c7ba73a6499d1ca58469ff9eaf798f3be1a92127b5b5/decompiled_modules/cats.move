module 0x654fce2078be866abb40c7ba73a6499d1ca58469ff9eaf798f3be1a92127b5b5::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 6, b"CATS", b"Everyone loves CATs", b"So cute CATs\\n. CATs are very cute\\n.Live with them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.hydropump.xyz/logo/01JEQB6Z4MXZ6JB105NA5F3RPA/01JEQBY7BQD8BNH9BKNTQQZ3BM")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

