module 0xf72badd32c965d91c2623db48fe1bc89e8dbd0566b26f1ec27e0a1fb28a7237b::dffa {
    struct DFFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFFA>(arg0, 9, b"DFFA", b"KJHASF", b"BBCzcx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2921b29-ae29-4156-a9f7-90773c8c669f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

