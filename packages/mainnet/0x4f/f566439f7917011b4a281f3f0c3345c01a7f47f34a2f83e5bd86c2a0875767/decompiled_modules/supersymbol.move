module 0x4ff566439f7917011b4a281f3f0c3345c01a7f47f34a2f83e5bd86c2a0875767::supersymbol {
    struct SUPERSYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSYMBOL>(arg0, 6, b"SMBL", b"Name", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSYMBOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERSYMBOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

