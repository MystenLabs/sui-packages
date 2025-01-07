module 0xa4705083743da45ad8a1b4df4ba992bef32084ea064915668c45d2d8e3ed083c::funtom {
    struct FUNTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNTOM>(arg0, 6, b"Funtom", b"Sui On Funtom", b"Dex aggregator,Swap,Farm & Launchpad memecoin sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/funtom_eb3a684e7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

