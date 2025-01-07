module 0xd56a542b49e3a7f8d8a976489487b4e7ed3dbe6216c2e946b05cf8eb001e870b::jdjdiidj {
    struct JDJDIIDJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDJDIIDJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDJDIIDJ>(arg0, 9, b"JDJDIIDJ", b"Irjrh", b"Nyc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9591ed89-24d0-4454-8339-523754854aec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDJDIIDJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDJDIIDJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

