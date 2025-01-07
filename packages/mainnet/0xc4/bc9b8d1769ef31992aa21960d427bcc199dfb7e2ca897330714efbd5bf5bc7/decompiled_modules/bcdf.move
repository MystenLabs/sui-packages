module 0xc4bc9b8d1769ef31992aa21960d427bcc199dfb7e2ca897330714efbd5bf5bc7::bcdf {
    struct BCDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCDF>(arg0, 9, b"BCDF", b"Bvcd", b" Xxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc1c5a12-1c9b-46cb-bdc7-1d082ed1904d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

