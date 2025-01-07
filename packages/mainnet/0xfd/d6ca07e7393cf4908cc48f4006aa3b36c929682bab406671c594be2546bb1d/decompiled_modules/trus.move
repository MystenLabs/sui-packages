module 0xfdd6ca07e7393cf4908cc48f4006aa3b36c929682bab406671c594be2546bb1d::trus {
    struct TRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUS>(arg0, 9, b"TRUS", b"Trump_SUI", b"The first Trump coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1f29318-58b5-48da-ab32-c4492b0a68e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

