module 0x2aa032b7da0186b841b34ff60514839e88af14ae64502b691c24f0dc7b924bda::lgt {
    struct LGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGT>(arg0, 9, b"LGT", b"LilGod ", b"Description: LilGod Token is a revolutionary digital asset designed to empower individuals to create wealth and prosperity in their lives", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1eb721f9-c6fd-455c-9e52-2b453e171ca6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

