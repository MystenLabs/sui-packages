module 0x9eb426c171184d8f61e61b210dfc987d0368338885a66547374f0e6b3d2331d6::weth {
    struct WETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETH>(arg0, 6, b"WETH", b"Weirdosui", b"weirdosui on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cc87fa11ad521d9e5651ce3abce9c9b0_2320f3c276.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

