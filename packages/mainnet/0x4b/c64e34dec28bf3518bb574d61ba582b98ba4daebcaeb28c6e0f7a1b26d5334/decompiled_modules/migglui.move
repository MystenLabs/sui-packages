module 0x4bc64e34dec28bf3518bb574d61ba582b98ba4daebcaeb28c6e0f7a1b26d5334::migglui {
    struct MIGGLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGGLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGGLUI>(arg0, 6, b"MIGGLUI", b"MIGGLES ON SUI", b"The Infamous \"Miggles\" The Cat has arrived from Base and is now to embark his journey on Sui!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/miggles_on_sui_logo_d257425297.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGGLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIGGLUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

