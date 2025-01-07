module 0x46e2692b9bdab65978d963433a29aaa24469aa8e5b394e372ba974120b1fa3fa::suibydoo {
    struct SUIBYDOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBYDOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBYDOO>(arg0, 6, b"SUIBYDOO", b"SUIBY DOO", b"HOW ARE YOU BRUH? SUIBY-DOOOOOOOOOOO!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_suibydoo_5e0d258ae6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBYDOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBYDOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

