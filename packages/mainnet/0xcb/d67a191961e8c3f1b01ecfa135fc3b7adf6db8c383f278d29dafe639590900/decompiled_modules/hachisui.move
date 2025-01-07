module 0xcbd67a191961e8c3f1b01ecfa135fc3b7adf6db8c383f278d29dafe639590900::hachisui {
    struct HACHISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHISUI>(arg0, 6, b"HACHISUI", b"Hachikun Inu", b"Hachikun Inu isnt just another dog in the meme coin race were here to build a lasting legacy. Inspired by the legendary loyalty of Hachiko, were all about creating a tight knit community where every member feels valued and respected.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_WITHOUT_TEXT_copy_4d9f9e472f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

