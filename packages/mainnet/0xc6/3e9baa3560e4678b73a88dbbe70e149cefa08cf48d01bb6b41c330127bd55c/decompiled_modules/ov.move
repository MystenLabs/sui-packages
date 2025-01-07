module 0xc63e9baa3560e4678b73a88dbbe70e149cefa08cf48d01bb6b41c330127bd55c::ov {
    struct OV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OV>(arg0, 9, b"OV", b"Oval", b"Talks about beautiful shapes of women ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ede35b2-ad77-44df-bbe6-ee32cbec6bc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OV>>(v1);
    }

    // decompiled from Move bytecode v6
}

