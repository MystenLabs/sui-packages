module 0x5d5760587c312bc7fb25b89fee53b2cafb8cb514e6481e3dd73bc57f21ae9ed::hedg {
    struct HEDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDG>(arg0, 9, b"HEDG", b"hedgehog", b"a cute hedgehog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72d8489e-227b-4c6e-bcae-c0d0a5b3b00f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

