module 0xe1feec4679334c813bf3b17a9fcf86837d599acd2b04505fb3849e192c8a7eb6::suipochita {
    struct SUIPOCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOCHITA>(arg0, 6, b"SUIPOCHITA", b"POCHITA", x"506f63686974612069732074686520736973746572206f662042616c6c747a652028434845454d5329200a0a426f6e6b27732073697374657220506f636869746120697320746865206e657720646f67206f6e2074686520626c6f636b200a583a2068747470733a2f2f782e636f6d2f706f6368697461736f6c63746f0a5765623a2068747470733a2f2f706f63686974612e62697a2f0a434e3a2068747470733a2f2f742e6d652f706f63686974616368696e65736563746f0a4d656d65733a2040706f63686974616d656d656368616e6e656c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3511_d6864929ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPOCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

