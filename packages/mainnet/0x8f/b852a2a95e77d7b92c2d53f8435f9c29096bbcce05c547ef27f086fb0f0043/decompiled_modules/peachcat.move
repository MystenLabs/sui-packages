module 0x8fb852a2a95e77d7b92c2d53f8435f9c29096bbcce05c547ef27f086fb0f0043::peachcat {
    struct PEACHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACHCAT>(arg0, 6, b"PEACHCAT", b"Peach Cat", b"Its a cat and a peach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8c_Ai_VL_2p_400x400_fc7917842a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

