module 0x8948ba8d99a3c4f0835ed6d48d8993da4dbf8bc8945c084fc3f640e616b3e87e::bc {
    struct BC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BC>(arg0, 9, b"BC", b"Battle ", b"Battele bigger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4fc489aa-17f3-4cee-82f3-6403ec7764a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BC>>(v1);
    }

    // decompiled from Move bytecode v6
}

