module 0xb673a175bdfe99d6e7a60ec3e5cffc598ea541dc00a24bac9bcc036b3629b0de::sandp420 {
    struct SANDP420 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDP420, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDP420>(arg0, 6, b"SANDP420", b"S&P 420", b"Sui and Proud 420!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Comp1_ezgif_com_video_to_gif_converter_3_5e173054d7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDP420>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANDP420>>(v1);
    }

    // decompiled from Move bytecode v6
}

