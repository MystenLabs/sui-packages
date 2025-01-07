module 0x49eb0587b708810a60ab9753daaf3e10786c7a23d1b468a9b6d4213139551530::nig {
    struct NIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIG>(arg0, 9, b"NIG", b"NIGG", b"NI GG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4251471-deae-4f8b-b892-35a1aeb0c0d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

