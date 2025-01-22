module 0x6c8a3634591c3ba5741bb1c14f4befccaeec9269ab9f5a23894fdce3e604339::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WW>(arg0, 6, b"WW", b"ee by SuiAI", b"reee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0834_cb949c7d3f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

