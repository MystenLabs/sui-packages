module 0x7247eec9aca50ef4d2154133ff393cd54e83d3374566c4d24dc1e82e7e7c1fef::merman {
    struct MERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERMAN>(arg0, 6, b"MERMAN", b"Fin Diesel", b"Hi, Im Fin Diesel official Merman of the Sui Sea! My fish friends are buying seashells, but Im here buying the dip... still waiting for the tidal wave of profits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mermaid_0e755a53b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

