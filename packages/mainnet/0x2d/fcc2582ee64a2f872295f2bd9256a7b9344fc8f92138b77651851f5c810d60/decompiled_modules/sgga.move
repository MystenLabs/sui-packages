module 0x2dfcc2582ee64a2f872295f2bd9256a7b9344fc8f92138b77651851f5c810d60::sgga {
    struct SGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGGA>(arg0, 6, b"SGGA", b"SUI'GGA", x"5355492747474120706f77657220746f2063727970746f206e696767612e200a446973747269627574696f6e3a2039302520544f206e696767612053554927474741206c6f7665727320202d2031302520746f2063726561746f72732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIGGA_fe42c0b165.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

