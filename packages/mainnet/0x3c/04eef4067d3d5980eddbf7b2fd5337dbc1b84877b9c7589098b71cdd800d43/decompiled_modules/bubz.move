module 0x3c04eef4067d3d5980eddbf7b2fd5337dbc1b84877b9c7589098b71cdd800d43::bubz {
    struct BUBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBZ>(arg0, 6, b"BUBZ", b"BUBZY", b"bubz floating on sui waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_39_7015175bfa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

