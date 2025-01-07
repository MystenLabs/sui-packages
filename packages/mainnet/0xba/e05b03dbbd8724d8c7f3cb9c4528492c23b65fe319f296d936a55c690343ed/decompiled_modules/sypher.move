module 0xbae05b03dbbd8724d8c7f3cb9c4528492c23b65fe319f296d936a55c690343ed::sypher {
    struct SYPHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYPHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYPHER>(arg0, 6, b"SYPHER", b"Sypher Terminal", b"Your research AI agent $SYPHER https://thesypher.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/67564756_2580c00e9e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYPHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYPHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

