module 0xa4b9506ed631582f5d9057a74167d6bf1900393de5908a7d84f1b2877b8e308f::lkkkkkkkkk {
    struct LKKKKKKKKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKKKKKKKKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LKKKKKKKKK>(arg0, 9, b"LKKKKKKKKK", b"kkkkkkkkk", b"hgjhjhff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2154d958-d2c0-43e5-8540-1977ea9567ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LKKKKKKKKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LKKKKKKKKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

