module 0x20c7edfb0d7af229f0b1045cc30d384b4276dbb8753f02bdae532765d764927::fcs {
    struct FCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCS>(arg0, 6, b"FCS", b"FOCUS", b"FOCUSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirius_7791bf9f43.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

