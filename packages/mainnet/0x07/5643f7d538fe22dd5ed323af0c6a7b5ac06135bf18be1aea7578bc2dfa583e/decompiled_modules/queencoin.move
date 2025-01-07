module 0x75643f7d538fe22dd5ed323af0c6a7b5ac06135bf18be1aea7578bc2dfa583e::queencoin {
    struct QUEENCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEENCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUEENCOIN>(arg0, 9, b"QUEENCOIN", b"Queen", x"54686973206d656d6520636f696e2062656c6f6e677320746f2074686520477265617420517565656e206f6620456e676c616e640a54686973206d656d6520776173206372656174656420746f20636f6d6d656d6f726174652074686520717565656e0a4c6f76657273206f662074686520517565656e206f6620456e676c616e64206275792074686973206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98815626-d52b-4fdc-9d4e-974b881b5a4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUEENCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUEENCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

