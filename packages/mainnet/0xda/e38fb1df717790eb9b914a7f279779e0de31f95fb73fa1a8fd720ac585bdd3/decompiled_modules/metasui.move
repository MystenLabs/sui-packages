module 0xdae38fb1df717790eb9b914a7f279779e0de31f95fb73fa1a8fd720ac585bdd3::metasui {
    struct METASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: METASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METASUI>(arg0, 9, b"METASUI", b"Meta", b"Meta SUI si a detcentralized protocol that enables  users to stake Aleo Credits on the aleo blockchain network and earn Meta rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62b98f38-9293-4b87-879d-69f8ea66038e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

