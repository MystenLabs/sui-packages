module 0xba3290847b409365efdaec7b20fab87f18dbdafa80264bbd37ede5fc7d55d0ca::blackcs {
    struct BLACKCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKCS>(arg0, 6, b"BLACKCS", b"BLACK CAT SUI", b"IM BLACK CAT ON SUI CHAIN DYOR ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eqbwy_wj_wcqh0mfjhowjmulj0oirkejjt75ulyrjnpcnn5z_6132025cc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

