module 0x4d00c2f55094f99054d3bfe18757ce1e25649bdff3eb0f7d3e1857c6c8b3ba27::sadf {
    struct SADF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADF>(arg0, 9, b"SADF", b"FDH", b"VCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdacc32a-7e37-46ab-80c3-65e7684879da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADF>>(v1);
    }

    // decompiled from Move bytecode v6
}

