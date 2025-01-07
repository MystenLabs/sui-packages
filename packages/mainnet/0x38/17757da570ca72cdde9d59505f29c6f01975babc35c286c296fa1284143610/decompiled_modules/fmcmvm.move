module 0x3817757da570ca72cdde9d59505f29c6f01975babc35c286c296fa1284143610::fmcmvm {
    struct FMCMVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMCMVM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMCMVM>(arg0, 9, b"FMCMVM", b"Tsjaksm", b"Ndndndm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40cc15b7-3939-40b4-816b-84fd21d6083d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMCMVM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMCMVM>>(v1);
    }

    // decompiled from Move bytecode v6
}

