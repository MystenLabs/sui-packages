module 0xecd4b89a47d16d987962036c7bc8149fb9db899962d31dccd0b1217624a31c45::suiny {
    struct SUINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINY>(arg0, 6, b"SUINY", b"SUINY  PICTURES", b"LIVE YOUR MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_11_A_s_00_18_48_c17b48ac_03ffc147f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

