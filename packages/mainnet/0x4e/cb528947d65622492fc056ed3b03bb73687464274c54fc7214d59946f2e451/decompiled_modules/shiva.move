module 0x4ecb528947d65622492fc056ed3b03bb73687464274c54fc7214d59946f2e451::shiva {
    struct SHIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIVA>(arg0, 6, b"SHIVA", b"SHIVA CAT", b"First worldwide ticker. Cat/Sticker/Mascot Building strong community. #", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_YJU_G3_B_400x400_7b2cf41fc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

