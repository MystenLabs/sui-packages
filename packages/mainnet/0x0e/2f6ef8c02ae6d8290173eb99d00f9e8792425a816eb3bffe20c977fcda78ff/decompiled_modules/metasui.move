module 0xe2f6ef8c02ae6d8290173eb99d00f9e8792425a816eb3bffe20c977fcda78ff::metasui {
    struct METASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: METASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METASUI>(arg0, 9, b"METASUI", b"Meta", b"MetaSUI si a detcentralized protocol that enables  users to stake Aleo Credits on the aleo blockchain network and earn MetaSUI rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcf8e445-7357-451b-ab17-374decccd567.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

