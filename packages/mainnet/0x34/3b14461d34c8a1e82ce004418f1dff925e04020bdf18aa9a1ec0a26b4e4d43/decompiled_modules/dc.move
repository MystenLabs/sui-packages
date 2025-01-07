module 0x343b14461d34c8a1e82ce004418f1dff925e04020bdf18aa9a1ec0a26b4e4d43::dc {
    struct DC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DC>(arg0, 9, b"DC", b"Dig Coin", b"This coin is for the digital marketing community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/288189ea-cc9a-437b-9a4f-33183da60804.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DC>>(v1);
    }

    // decompiled from Move bytecode v6
}

