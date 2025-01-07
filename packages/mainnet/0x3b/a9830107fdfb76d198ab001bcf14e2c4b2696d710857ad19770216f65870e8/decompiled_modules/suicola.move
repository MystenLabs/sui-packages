module 0x3ba9830107fdfb76d198ab001bcf14e2c4b2696d710857ad19770216f65870e8::suicola {
    struct SUICOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOLA>(arg0, 6, b"Suicola", b"SUICOLA", b"i am sui cola drink drink drink", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fd80a485_fb40_48ec_ba8a_90c41ed04334_7399e6b735.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

