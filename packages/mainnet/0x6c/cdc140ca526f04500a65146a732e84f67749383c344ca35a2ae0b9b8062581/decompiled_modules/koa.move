module 0x6ccdc140ca526f04500a65146a732e84f67749383c344ca35a2ae0b9b8062581::koa {
    struct KOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOA>(arg0, 6, b"KOA", b"KOALA", b"I'm $KOA!I'm Pepe's bestie for real!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_N_Zn_M_Uc_400x400_e2e85c1e25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

