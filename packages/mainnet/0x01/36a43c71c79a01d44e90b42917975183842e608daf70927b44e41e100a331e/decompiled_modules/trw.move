module 0x136a43c71c79a01d44e90b42917975183842e608daf70927b44e41e100a331e::trw {
    struct TRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRW>(arg0, 9, b"TRW", b"WATER", x"57697468205741544552204d656d65636f696e2c20612072656672657368696e6720616e64207375737461696e61626c65206469676974616c2063757272656e637920696e7370697265642062792074686520766974616c20616e64206c6966652d676976696e6720656c656d656e74206f662077617465720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e91b49b-462d-443f-86bd-7446a1d49a75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRW>>(v1);
    }

    // decompiled from Move bytecode v6
}

