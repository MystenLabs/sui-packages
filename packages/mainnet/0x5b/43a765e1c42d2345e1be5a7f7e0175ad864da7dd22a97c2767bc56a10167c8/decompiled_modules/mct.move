module 0x5b43a765e1c42d2345e1be5a7f7e0175ad864da7dd22a97c2767bc56a10167c8::mct {
    struct MCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCT>(arg0, 9, b"MCT", b"myCAT", b"my cat on PC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7c41a58-1dd6-4d55-9236-2678fef939ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

