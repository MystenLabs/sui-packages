module 0xe4b5a8f19926671f0828c9cd27be61dbb658ca588f05a5d0c412b60f6fa52c48::bdsm {
    struct BDSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDSM>(arg0, 6, b"BDSM", b"BDSM on Sui", b"BDSM is a guiding light for those who are not afraid to swim against the tide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002922_219ca665c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

