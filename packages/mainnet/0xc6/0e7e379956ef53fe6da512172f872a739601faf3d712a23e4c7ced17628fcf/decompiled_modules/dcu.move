module 0xc60e7e379956ef53fe6da512172f872a739601faf3d712a23e4c7ced17628fcf::dcu {
    struct DCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCU>(arg0, 9, b"DCU", b"Duck", b"Duck Duck GO! The duck is a symbol of decentralization and freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fcc9a0e-8ee6-4be4-bf1d-b0c197d6df78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCU>>(v1);
    }

    // decompiled from Move bytecode v6
}

