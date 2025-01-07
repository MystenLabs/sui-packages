module 0x5cce40cc6f6d03b7f4066ffac614fd7b6742c450659faf628a256613298a400f::mfit {
    struct MFIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFIT>(arg0, 9, b"MFIT", b"MetersFit", x"54686520776f726c64e2809973206d6f737420616476616e636564206669746e657373206173736573736d656e7420706c6174666f726d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2988a458-2503-4cdf-9be5-ef17d3f6421d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

