module 0x5f49d6f3c093db90ce8fca94c4912a3108c0b0ae3836cfb88f272dcb2e397a98::tadpolesui {
    struct TADPOLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADPOLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADPOLESUI>(arg0, 6, b"TADPOLESUI", b"TADPOLE", b"Tadpole is more than just hype, it's here to stay.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_211811489_f6bd74679c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADPOLESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADPOLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

