module 0xe0fa2a419d603c449062495ad99192e5747f51428411474de8897e9f28e6c4cd::gbl {
    struct GBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBL>(arg0, 9, b"GBL", b"GOLDENBOOL", b"Bull Market Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fca50f27-6291-48e5-8de0-1c8b635e2dd4-1000019199.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

