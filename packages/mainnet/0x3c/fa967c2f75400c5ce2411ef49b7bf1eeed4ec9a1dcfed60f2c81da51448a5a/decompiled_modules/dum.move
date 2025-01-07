module 0x3cfa967c2f75400c5ce2411ef49b7bf1eeed4ec9a1dcfed60f2c81da51448a5a::dum {
    struct DUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUM>(arg0, 9, b"DUM", b"Dummy", b"Dummy panda not a real panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/408c2575-b8a8-4015-93f1-5cf9fb8d49ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

