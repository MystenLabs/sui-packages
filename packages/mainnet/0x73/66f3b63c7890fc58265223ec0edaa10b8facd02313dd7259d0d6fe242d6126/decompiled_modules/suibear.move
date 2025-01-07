module 0x7366f3b63c7890fc58265223ec0edaa10b8facd02313dd7259d0d6fe242d6126::suibear {
    struct SUIBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEAR>(arg0, 6, b"SUIBEAR", b"Sui Bear", b"SUIBEAR intense drive and unflinching conviction will undoubtedly have a long-term impact on the market this season.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_17_08_44_796599aac0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

