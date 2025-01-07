module 0x4d9b3bac88f29b330afa2ca0a053a5ff75bc5a9cad5af2005d1bc1c3039602a8::hrt {
    struct HRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRT>(arg0, 9, b"HRT", b"heart", x"496e6675736520796f757220696e766573746d656e74732077697468204865617274436f696e3a2054686520686561727466656c742063727970746f63757272656e6379207468617427732070756d70696e67206c6f766520616e642070617373696f6e20696e746f20796f757220706f7274666f6c696f20e29da4efb88fe29da4efb88fe29da4efb88fe29da4efb88fe29da4efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/551a68ae-e561-459e-8bd6-2211f2637d4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

