module 0xdaec8a183231f01c02c811a262eec8f2e665d43021b48dc12d49fe6f27ada199::metasui {
    struct METASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: METASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METASUI>(arg0, 9, b"METASUI", b"Meta", b"Meta SUI si a detcentralized protocol that enables  users to stake Aleo Credits on the aleo blockchain network and earn Meta rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/663f2443-fdf8-45e7-827c-12b1027d8777.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

