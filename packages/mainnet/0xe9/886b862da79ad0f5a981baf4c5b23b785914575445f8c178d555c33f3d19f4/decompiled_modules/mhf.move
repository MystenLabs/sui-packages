module 0xe9886b862da79ad0f5a981baf4c5b23b785914575445f8c178d555c33f3d19f4::mhf {
    struct MHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHF>(arg0, 9, b"MHF", b"GDD", b"Good morning I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02e38279-1fc6-4580-b292-7a595e0dea66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHF>>(v1);
    }

    // decompiled from Move bytecode v6
}

