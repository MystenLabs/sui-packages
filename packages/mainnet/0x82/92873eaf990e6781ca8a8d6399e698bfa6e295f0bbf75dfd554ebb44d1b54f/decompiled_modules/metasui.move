module 0x8292873eaf990e6781ca8a8d6399e698bfa6e295f0bbf75dfd554ebb44d1b54f::metasui {
    struct METASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: METASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METASUI>(arg0, 9, b"METASUI", b"Meta", b"Meta SUI si a detcentralized protocol that enables  users to stake Aleo Credits on the aleo blockchain network and earn Meta rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/998f7c9c-12c4-4b29-802f-fc38f6eb4afa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

