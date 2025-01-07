module 0xeddaf9935315e920773c9ed2a4e76aa05c6008efa8f7a163e5d188b7edad70b9::fini {
    struct FINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINI>(arg0, 6, b"FINI", b"Finni World RPG", b"GAME IS LIVE NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FINI_T_Euu_R9_uj_Em5_X_Sjwg_CY_417e257e47.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

