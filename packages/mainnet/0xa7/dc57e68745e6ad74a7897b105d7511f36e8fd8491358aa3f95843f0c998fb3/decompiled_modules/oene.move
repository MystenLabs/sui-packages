module 0xa7dc57e68745e6ad74a7897b105d7511f36e8fd8491358aa3f95843f0c998fb3::oene {
    struct OENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OENE>(arg0, 9, b"OENE", b"nnb", b"ejdn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ebc3b16-ce40-47de-abd7-1a5bed258ac6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

