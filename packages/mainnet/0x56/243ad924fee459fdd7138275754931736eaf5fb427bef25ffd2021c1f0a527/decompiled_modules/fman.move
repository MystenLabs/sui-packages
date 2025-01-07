module 0x56243ad924fee459fdd7138275754931736eaf5fb427bef25ffd2021c1f0a527::fman {
    struct FMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMAN>(arg0, 6, b"FMAN", b"FIRE MAN SUI", b"meme token on the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_XPD_7_Du_L_400x400_419333f268.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

