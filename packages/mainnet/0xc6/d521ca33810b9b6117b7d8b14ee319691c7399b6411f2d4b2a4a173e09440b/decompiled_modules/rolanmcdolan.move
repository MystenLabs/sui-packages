module 0xc6d521ca33810b9b6117b7d8b14ee319691c7399b6411f2d4b2a4a173e09440b::rolanmcdolan {
    struct ROLANMCDOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLANMCDOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLANMCDOLAN>(arg0, 6, b"RolanMcDolan", b"Rolan McDolan", b"Rolan McDolan, the hilariously off-brand version of the famous chain, where the burgers are almost round, and the service is as uneven as its poorly drawn logo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_11_d69a38c499.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLANMCDOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLANMCDOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

