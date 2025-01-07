module 0xa29b13688d8b9149f4d686957ad402bcd7eb114ee7b3d83166b78f3b80058884::gemsui {
    struct GEMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMSUI>(arg0, 6, b"GEMSUI", b"Gemini SUI", b"Google Gemini generated AI in SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_SUI_4aff82029b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

