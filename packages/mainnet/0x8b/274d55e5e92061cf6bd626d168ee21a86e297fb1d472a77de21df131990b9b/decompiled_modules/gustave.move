module 0x8b274d55e5e92061cf6bd626d168ee21a86e297fb1d472a77de21df131990b9b::gustave {
    struct GUSTAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSTAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSTAVE>(arg0, 6, b"GUSTAVE", b"GUSTAVE SUI", b"Gustave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/91306d_843903dc9b574292af3ede1e30c891ff_mv2_1f1f76807f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSTAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUSTAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

