module 0x3d642145e54c613176e0a538321962dbfbcb3d042525ff431a6b008524258e09::yotuo {
    struct YOTUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOTUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOTUO>(arg0, 9, b"YOTUO", b"KFFFWO", b"SFFRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5dfc8d0f-49ac-4c68-a7af-776966de73d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOTUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOTUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

