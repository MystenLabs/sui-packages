module 0x8543a8a09e0aea2895df4c56ab2c40e4f0c6e22e28faf4d6e982b78049997d07::hp {
    struct HP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HP>(arg0, 9, b"HP", b"Handphone", b"Handphone jadul. Alat komunikasi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e0c7e7e-ed6c-416e-9c2f-7f0a638b0ee3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HP>>(v1);
    }

    // decompiled from Move bytecode v6
}

