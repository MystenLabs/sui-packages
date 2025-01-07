module 0xba15f3039fe87f006cb7f1696b6a4f44f3bac1c14fa2aa5e09345385e96e1557::cati {
    struct CATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATI>(arg0, 9, b"CATI", b"CATIZEN", b"CATI is a utility token built on the TON BLOCKCHAIN network, with the aim of facilitating transactions within the decentralized ecosystem of dApps focused on the cryptocurrency economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47ed619f-c6c2-4465-8d60-05950b89124b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

