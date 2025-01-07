module 0x8ebededc4758e410d707e79e807125c6202c52a485f44a140336f96ec82ab8df::staceman {
    struct STACEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STACEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STACEMAN>(arg0, 9, b"STACEMAN", b"STACE", x"5468697320697320612073746f7279206f6620612070726f6475637469766520616e6420696e666c75656e7469616c20656d7065726f72202063616c6c656420535441434520f09f9181efb88fe2808df09f97a8efb88f20454d5049524520f09f91a8f09f8fbde2808df09f8ea8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91404008-e013-4bd9-b2ce-3242cd301987.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STACEMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STACEMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

