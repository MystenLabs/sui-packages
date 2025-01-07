module 0x62f9977a3495011a21fdf95a61de376f5fae9d0747ee438fa1e7f57c070e1b29::bkrw {
    struct BKRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKRW>(arg0, 6, b"BKRW", b"Bober KRW", b"Bober KRW ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bkrw_a87a43d66a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKRW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKRW>>(v1);
    }

    // decompiled from Move bytecode v6
}

