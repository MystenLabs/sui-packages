module 0x44a0dee1ca273a2d8a610bcd05895ca90fbcaa764a8ae4230ff6e26a437fdacc::w123456789 {
    struct W123456789 has drop {
        dummy_field: bool,
    }

    fun init(arg0: W123456789, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W123456789>(arg0, 9, b"W123456789", b"Wave", b"H-andsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fd2cd2f-e09e-4a39-a59a-5d2d7af03982.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W123456789>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W123456789>>(v1);
    }

    // decompiled from Move bytecode v6
}

