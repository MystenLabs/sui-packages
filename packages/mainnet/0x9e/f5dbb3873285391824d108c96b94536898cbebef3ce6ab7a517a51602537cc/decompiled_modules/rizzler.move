module 0x9ef5dbb3873285391824d108c96b94536898cbebef3ce6ab7a517a51602537cc::rizzler {
    struct RIZZLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZLER>(arg0, 6, b"RIZZLER", b"Rizzler", x"5468652062696767657374206d656d65206f662032303234202452495a5a4c45520a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iu_Tc_H9d_D_400x400_caa28961a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

