module 0x782ebbbdc0268030460acde082e65eda7b9323a04c36c23c2ccb043759a48c58::eid_mubara {
    struct EID_MUBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EID_MUBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EID_MUBARA>(arg0, 9, b"EID_MUBARA", b"EidMubarak", b"Eid Mubarak to all Muslim and all non Muslim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76ec836f-faca-45da-8b87-6db0ec8b43fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EID_MUBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EID_MUBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

