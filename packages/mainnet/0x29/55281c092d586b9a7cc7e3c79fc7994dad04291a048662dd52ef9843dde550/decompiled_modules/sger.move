module 0x2955281c092d586b9a7cc7e3c79fc7994dad04291a048662dd52ef9843dde550::sger {
    struct SGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGER>(arg0, 6, b"SGER", b"SUIGER", b"SUIGER WILL TOP 1 MEME ON SUI. BUY SOME SGER AND DYOR ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_91_3c3a8190e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

