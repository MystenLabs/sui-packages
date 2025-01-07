module 0xc90d8c4f45a206c11e688447fce0d5ceba312396fe0418da562666d29a371503::fastman {
    struct FASTMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASTMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASTMAN>(arg0, 9, b"FASTMAN", b"Dallarmem", b"Decor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/341d4093-d1f3-4887-b82e-c51045567a18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASTMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FASTMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

