module 0xda926fa2cc1d95658c5d8774c6b54718958ac549886aeb682ae3447056fe7a80::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKY>(arg0, 6, b"RICKY", b"Ricky The Penguin", x"4865792c2069742773205269636b79210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pinguino_para_ia_eafb6b7c8d_a4df228bf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

