module 0xedd4f3d8969cb7c34f4b846453177967c9a6e3cd2c758d1e5f5ea3c63bbd5160::madt {
    struct MADT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADT>(arg0, 9, b"MADT", b"MAD", b"MAD (Make My Dream) is a new memecoin designed to empower its community by turning dreams into reality. With its light-hearted and fun branding, ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c13a5935-61d8-4622-bbcc-d0d81a8d9e03-1000023415.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MADT>>(v1);
    }

    // decompiled from Move bytecode v6
}

