module 0xc3cf3d02bf77bbd3652eb13c65bd308c9583a655fbc76ec719f99dc71689583e::sfcs {
    struct SFCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFCS>(arg0, 9, b"SFCS", b"CXB", b"SFGDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/579a3193-c0eb-4513-ae2f-8f9d12f7b64b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

