module 0x7656139b1e08af302dfdce0ca9d8bb4873307a0e68b2cbfbd8d4a370c4b6c43c::iebdd {
    struct IEBDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: IEBDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IEBDD>(arg0, 9, b"IEBDD", b"ndndn", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7591d6e2-5250-4478-b753-7c16fa30424b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IEBDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IEBDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

