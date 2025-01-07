module 0xa6b1c007c8d5ed11f7ac96b0acca998f170a255d1ff40d5281c1a042a2e86c66::sji {
    struct SJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJI>(arg0, 9, b"SJI", b"Saiji", b"Purely meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8c7dbca-1727-4556-9a15-2983d34942e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

