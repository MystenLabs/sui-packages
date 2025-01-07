module 0x55a0aae2d5fe10d854afcda9e0974d812f4f81620817f028c9806ca763534e19::hlij {
    struct HLIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLIJ>(arg0, 9, b"HLIJ", b"hah", b"df", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4757729-e45d-42f7-a212-19305ad542e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLIJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

