module 0x4a2974d24c2df3baa8e56fdbc79df36b73a4dec0c0d068021738cf3a93222f00::vram {
    struct VRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VRAM>(arg0, 6, b"VRAM", b"VRAM.AI by SuiAI", x"54686520666972737420536f6369616c4149204167656e74204c61756e636870616420616e64204672616d65776f726b2c20656e61626c696e6720636f6c6c61626f72617469766520646576656c6f706d656e74e28094706f77657265642062792069747320636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_26_192811_30ca57929c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VRAM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRAM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

