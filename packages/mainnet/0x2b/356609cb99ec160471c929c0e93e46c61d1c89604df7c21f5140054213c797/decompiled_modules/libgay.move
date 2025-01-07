module 0x2b356609cb99ec160471c929c0e93e46c61d1c89604df7c21f5140054213c797::libgay {
    struct LIBGAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBGAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBGAY>(arg0, 6, b"Libgay", b"libtard gay shit", b"don't look twitter ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vaabc_X20_400x400_9afc6ecf70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBGAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIBGAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

