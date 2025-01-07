module 0x8137525cc550077f28f327b781039369435bc01d97326498bbee426200eb794e::drog {
    struct DROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROG>(arg0, 6, b"DROG", b"Frog Dog", b"Bark or ribbit? Ribbark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_8_c1e7195481.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

