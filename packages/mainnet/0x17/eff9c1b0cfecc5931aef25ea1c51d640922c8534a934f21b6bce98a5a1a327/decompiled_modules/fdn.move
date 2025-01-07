module 0x17eff9c1b0cfecc5931aef25ea1c51d640922c8534a934f21b6bce98a5a1a327::fdn {
    struct FDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDN>(arg0, 9, b"FDN", b"Foundon", x"466f756e646f6e202846444e292069732061207574696c69747920746f6b656e20706f776572696e672074686520466f756e646f6e2065636f73797374656d2c206120646563656e7472616c697a656420706c6174666f726d20636f6e6e656374696e6720656e7472657072656e657572732c20696e766573746f72732c20616e64206d656e746f72732e200a0a466f756e646f6e2773206d697373696f6e20697320746f2064656d6f63726174697a6520737461727475702067726f77746820616e6420696e6e6f766174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/404fb11c-f7d1-47ee-beab-68e6fa307060.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

