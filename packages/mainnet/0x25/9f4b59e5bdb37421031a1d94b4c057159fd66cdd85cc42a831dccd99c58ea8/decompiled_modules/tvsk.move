module 0x259f4b59e5bdb37421031a1d94b4c057159fd66cdd85cc42a831dccd99c58ea8::tvsk {
    struct TVSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVSK>(arg0, 6, b"TvsK", b"Trump VS Kamala", b"Official Memecoin of the ultimate showdown!  $TRUMPvsKAMALA  Where politics meets cryptoride the volatility! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_SP_6_G_If6_Tge3_CSF_1c_GQ_Iv_Q_1616f1023b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TVSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

