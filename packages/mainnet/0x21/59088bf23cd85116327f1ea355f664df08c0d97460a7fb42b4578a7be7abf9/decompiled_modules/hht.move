module 0x2159088bf23cd85116327f1ea355f664df08c0d97460a7fb42b4578a7be7abf9::hht {
    struct HHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHT>(arg0, 9, b"HHT", b"hophoanton", b"HHHHT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ae3fff6-d65d-4a74-b3be-59ab60b54c0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

