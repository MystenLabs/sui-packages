module 0xe41d6d01e88515ac5bbdcb71cf3f27532c312f94b2d06dbb6dc8c5762e5a1398::pn {
    struct PN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PN>(arg0, 9, b"PN", b"PnutX", b"Meme, dex and gamefi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce244f71-1606-4dfc-b33f-0cec9422de2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PN>>(v1);
    }

    // decompiled from Move bytecode v6
}

