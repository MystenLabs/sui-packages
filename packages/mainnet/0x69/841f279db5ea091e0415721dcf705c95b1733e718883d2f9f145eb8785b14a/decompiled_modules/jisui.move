module 0x69841f279db5ea091e0415721dcf705c95b1733e718883d2f9f145eb8785b14a::jisui {
    struct JISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JISUI>(arg0, 6, b"JISUI", b"JISOO on SUI", x"54686520317374206d656d65636f696e2064656469636174656420666f72204a69736f6f2c206f6e20535549210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H8_Zh_T0_D3_400x400_3414df5113.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

