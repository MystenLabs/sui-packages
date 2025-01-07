module 0x35623466502508031038839628f4e334b7c07330ad1406cf5e05cde9974b6261::vampsui {
    struct VAMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAMPSUI>(arg0, 6, b"VAMPSUI", b"Vamp Sui", b"Thirsty for liquidity, $VAMPSUI prowls the Sui Network, draining every drop it finds. Slick and sly, this water-sucker is always hunting for the next juicy bite!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_73_44e27ef5d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

