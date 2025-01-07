module 0x616ff2ac4e71361507f495fbf167e1cca3c54525a0132c020820d9f4fd9559f3::tosui {
    struct TOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSUI>(arg0, 6, b"TOSUI", b"TOSHI ON SUI", b"TOSHI SUI - LEADING MEME SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tosui_9c655c1f2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

