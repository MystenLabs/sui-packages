module 0x5319b66bebdc14c68064350f5762cca5af713f1989f3f7e644169b866ceefbfa::pepsui {
    struct PEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSUI>(arg0, 6, b"PEPSUI", b"Pepsuiman", b"THE TICKER IS $PEPSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xa_NU_Lef_K_400x400_3a77e082fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

