module 0x540f454836268fecc83e8a9cf9a494db2299c2ed4fbfbe6c49c769b876abb7b::cockyyyy {
    struct COCKYYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCKYYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCKYYYY>(arg0, 6, b"COCKYYYY", b"COCKYYYY THE CHICK", b"We only say COCKYYYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e350de60_bd7b_4a1f_8732_e5a77964ab7f_b299a7bbd7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCKYYYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCKYYYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

