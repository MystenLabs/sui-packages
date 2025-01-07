module 0xd6cf672bbc95d060a5bdbb6e03c05eb4b32224b77273ff72e005b609e8dd1185::suiwarthog {
    struct SUIWARTHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARTHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARTHOG>(arg0, 6, b"SuiWarthog", b"Sui Warthog V6", b"Tiktok's most popular V6 engine on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001042096_5754805f48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARTHOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARTHOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

