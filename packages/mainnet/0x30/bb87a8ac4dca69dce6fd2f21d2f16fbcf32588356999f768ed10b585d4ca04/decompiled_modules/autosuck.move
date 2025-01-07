module 0x30bb87a8ac4dca69dce6fd2f21d2f16fbcf32588356999f768ed10b585d4ca04::autosuck {
    struct AUTOSUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTOSUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTOSUCK>(arg0, 6, b"AUTOSUCK", b"Auto Suck", x"576520646f6e277420776169742061726f756e6420666f7220616e796f6e652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_ezgif_com_optimize_738c6dded4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTOSUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTOSUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

