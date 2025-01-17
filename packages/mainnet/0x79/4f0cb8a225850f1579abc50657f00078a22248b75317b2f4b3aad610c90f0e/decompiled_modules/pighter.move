module 0x794f0cb8a225850f1579abc50657f00078a22248b75317b2f4b3aad610c90f0e::pighter {
    struct PIGHTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGHTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGHTER>(arg0, 9, b"PIGHTER", b"Pepe-27", b"Piu piu and you are dead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4fe7f89-85e0-4019-838e-841b54e9381a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGHTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIGHTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

