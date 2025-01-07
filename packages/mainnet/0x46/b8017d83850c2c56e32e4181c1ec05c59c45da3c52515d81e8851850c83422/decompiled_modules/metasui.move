module 0x46b8017d83850c2c56e32e4181c1ec05c59c45da3c52515d81e8851850c83422::metasui {
    struct METASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: METASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METASUI>(arg0, 9, b"METASUI", b"Meta", b"Meta SUI si a detcentralized protocol that enables  users to stake Aleo Credits on the aleo blockchain network and earn Meta rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b121f878-98da-43bf-9527-997801964115.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

