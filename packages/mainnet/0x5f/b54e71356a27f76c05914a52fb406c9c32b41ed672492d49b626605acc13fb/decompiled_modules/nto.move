module 0x5fb54e71356a27f76c05914a52fb406c9c32b41ed672492d49b626605acc13fb::nto {
    struct NTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTO>(arg0, 9, b"NTO", b"Nitroo", b"New token nitro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af4882fa-bd90-4108-bb3f-6c007587a8c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

