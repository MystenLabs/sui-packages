module 0xd501820ab5462a4fe822259e2ea2d52f864a60a23abd090ac81bcb59e0e012a6::lion {
    struct LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LION>(arg0, 6, b"LION", b"Suilion", b"colony of suilions taking over sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HWA_Au_XA_2_400x400_01dda52973.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LION>>(v1);
    }

    // decompiled from Move bytecode v6
}

