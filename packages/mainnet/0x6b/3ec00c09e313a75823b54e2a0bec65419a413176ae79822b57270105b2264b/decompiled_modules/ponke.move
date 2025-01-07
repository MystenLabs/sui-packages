module 0x6b3ec00c09e313a75823b54e2a0bec65419a413176ae79822b57270105b2264b::ponke {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 6, b"Ponke", b"PONKE", x"506f6e6b65204c616e64696e67206f6e205355490a4769622068696d207761726d2077656c636f6d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241005_232031_468_5ee7ae2235.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

