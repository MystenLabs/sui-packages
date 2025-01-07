module 0x4a154731859b8daab8ab0602bf22cb0efe39c0c59165e5dae19d1a432ba48c64::luxito {
    struct LUXITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUXITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUXITO>(arg0, 6, b"LUXITO", b"LUXITO SUI", b"Were bringing that same energy to the blockchain with $LUXITO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zrd_Hvb_XUA_Yx_Ux_J_7704484c36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUXITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUXITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

