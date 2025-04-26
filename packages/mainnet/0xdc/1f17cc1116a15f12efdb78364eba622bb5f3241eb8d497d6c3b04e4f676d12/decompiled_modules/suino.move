module 0xdc1f17cc1116a15f12efdb78364eba622bb5f3241eb8d497d6c3b04e4f676d12::suino {
    struct SUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINO>(arg0, 6, b"SUINO", b"SUIno", b"just a SUINO on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chat_GPT_Image_Apr_26_2025_at_10_36_08_AM_b396f0a0a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

