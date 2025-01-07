module 0xc41edc6d700dd8384f6e5f27afa4e1129f730fece4c14a1d85b778f8683c87e8::mbs {
    struct MBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBS>(arg0, 6, b"MBS", b"MB SUI", b"MEME MB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/35_357809_php_white_png_logo_transparent_png_65b7477b28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

