module 0xbad4bd0c3123dd879f68031fbaaedc000152f66bb35e171513e6f0cba9606119::ggh {
    struct GGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGH>(arg0, 9, b"GGH", b"Ghhh", b"Kiggj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/954bc45b-9779-4bf3-b588-997965e9627d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

