module 0xeb5ca8ee138905016a5acb24c9785668f12fa88ccd1af82239a15e49cbf6c558::zards {
    struct ZARDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARDS>(arg0, 6, b"ZARDS", b"SUIZARDS", b"2 BROS CASTING THINGS ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h0bdq_H_Rx_400x400_b04cdec976.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZARDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

