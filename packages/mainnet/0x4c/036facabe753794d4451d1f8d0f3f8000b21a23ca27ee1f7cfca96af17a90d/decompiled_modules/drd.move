module 0x4c036facabe753794d4451d1f8d0f3f8000b21a23ca27ee1f7cfca96af17a90d::drd {
    struct DRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRD>(arg0, 9, b"DRD", b"Druid", b"Druid World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/066827ec-7aab-4c9e-85a5-a4ad6559615f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

