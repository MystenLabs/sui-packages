module 0xb3f0621812eb686a622a459af90565e3495883fca3ddf90f52bfcff39c8f0f1e::owlg {
    struct OWLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLG>(arg0, 6, b"OWLG", b"OWL G", b"The OG OWL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731503859056.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWLG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

