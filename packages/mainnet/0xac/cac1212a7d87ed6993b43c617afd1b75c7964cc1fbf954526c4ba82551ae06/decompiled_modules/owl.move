module 0xaccac1212a7d87ed6993b43c617afd1b75c7964cc1fbf954526c4ba82551ae06::owl {
    struct OWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWL>(arg0, 6, b"OWL", b"HOPOWL OWL", b"The First OWL on Hop.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950895877.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

