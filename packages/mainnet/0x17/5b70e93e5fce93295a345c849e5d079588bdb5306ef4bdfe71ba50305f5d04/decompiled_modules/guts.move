module 0x175b70e93e5fce93295a345c849e5d079588bdb5306ef4bdfe71ba50305f5d04::guts {
    struct GUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUTS>(arg0, 9, b"GUTS", b"Guts Dogs ", x"2447555453206d656d65636f696e7320696e66726173747275637475726520636f6d6d756e697479206275696c6420616e64206b65657020636f6f6b20f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c85e387-1bb1-44d1-9027-b2b0536526a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

