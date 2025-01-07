module 0xfbe06347d2fbb110301e93beccdaeac0f9810da29825395d2a8256d068333839::drt {
    struct DRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRT>(arg0, 9, b"DRT", b"DARTS", b"imagine your goal and aim toward it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89113bc0-420c-473c-b9cb-e53964339b50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

