module 0x38a52746634489a748184485bbbe3baa57d46fbb55f61c1c583dfb9e6ca7ce95::towel {
    struct TOWEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOWEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOWEL>(arg0, 6, b"Towel", b"Towel cat", b"Just cute cat wrapped in a towel, once bonded socials will be created ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_f83189495a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOWEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOWEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

