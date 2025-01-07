module 0x7d644faf76e7f2061989d03423360c3cb154ab99dd3eee6cd2dc50ed31da7bd5::xbcnnc {
    struct XBCNNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBCNNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBCNNC>(arg0, 9, b"XBCNNC", b"Syajwn", b"Cnndndnx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec71c385-84de-4c9b-ae62-0c64e2ef19b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBCNNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBCNNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

