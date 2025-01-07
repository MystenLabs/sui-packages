module 0xe1e22f289440c3e68771ba17323bfb9581fd1b8c546b45938982b5878e2f1452::lgt {
    struct LGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGT>(arg0, 9, b"LGT", b"Lilgod ", b"LilGod Token is a revolutionary digital asset designed to empower individuals to create wealth.$LILGOD aims to bridge the gap between the physical and metaphysical worlds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/943e3a5a-b208-4ba0-a39f-79986ba54297.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

