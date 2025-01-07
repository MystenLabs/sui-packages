module 0xb6f7a2b26c61dbbe2ae69774076793fb8f7a8b35b825ac98d67535c6d52188f2::szx {
    struct SZX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZX>(arg0, 9, b"SZX", b"SABZI", b"ENDLESS GREEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f1f2dc0-64f7-44ea-88dd-01e7348949cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SZX>>(v1);
    }

    // decompiled from Move bytecode v6
}

