module 0xcf52a75c45af735e51276d81ce7f3947c10459f55f590407711acf462ac250ee::peitama {
    struct PEITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEITAMA>(arg0, 6, b"PEITAMA", b"Peitama On Sui", b"The power of pei pei pei $PEITAMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/042b74_ed24ad4a838b4ddfb178cd6c92daf2d5_mv2_1_aeeabfa4b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

