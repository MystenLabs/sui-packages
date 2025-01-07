module 0xa11ee553de9672c586287604b31a4b96fde01aa2e5ac317f0b5fa1348ff3d7c0::psd {
    struct PSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSD>(arg0, 6, b"PSD", b"PoSuidon", x"5468697320697320746865206f6666696369616c20746f6b656e206f66204c6f726420506f737569646f6e2e0a4c6574207468652077617465727320666c6f772e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732075933686.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

