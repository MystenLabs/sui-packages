module 0x75a16f5fb7e3b9bc0d1a0e62086f1c6ed2d300bd88239494648083060cfb021::gmichi {
    struct GMICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMICHI>(arg0, 6, b"Gmichi", b"Giko Michi on Sui", b"send all cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZI_Qh3_Wg_A_Aq_t_P_1b74dd84a5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

