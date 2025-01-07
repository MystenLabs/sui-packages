module 0xdb3a886e63929b7227a959fb7f9f434f8b00f3658bbd97998dac5a0bdd9aa0d0::cheers {
    struct CHEERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEERS>(arg0, 6, b"CHEERS", b"CheerSUI", b"Here's to SUI, old chum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cheersui_c76800cf79.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

