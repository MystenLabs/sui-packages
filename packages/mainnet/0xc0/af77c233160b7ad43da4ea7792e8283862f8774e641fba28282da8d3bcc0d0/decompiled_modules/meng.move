module 0xc0af77c233160b7ad43da4ea7792e8283862f8774e641fba28282da8d3bcc0d0::meng {
    struct MENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENG>(arg0, 9, b"MENG", b"Kucing Ore", b"An Oren-colored cat, who always shows a degree of adorable and nosy determination", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f818e97c-b58a-4c19-a246-7502ba478891.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

