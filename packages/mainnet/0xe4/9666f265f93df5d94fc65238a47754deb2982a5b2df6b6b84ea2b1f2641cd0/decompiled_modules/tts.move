module 0xe49666f265f93df5d94fc65238a47754deb2982a5b2df6b6b84ea2b1f2641cd0::tts {
    struct TTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTS>(arg0, 6, b"Tts", b"tts", b"fsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/81_Yna_M8_Gt_L_AC_UF_1000_1000_QL_80_267f28d7a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

