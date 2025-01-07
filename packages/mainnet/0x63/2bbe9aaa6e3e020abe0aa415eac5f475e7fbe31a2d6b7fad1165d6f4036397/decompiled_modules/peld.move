module 0x632bbe9aaa6e3e020abe0aa415eac5f475e7fbe31a2d6b7fad1165d6f4036397::peld {
    struct PELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELD>(arg0, 6, b"PELD", b"PEPE GOLD", b"RealPepeGold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pepe_Gold_PFP_454681e546.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELD>>(v1);
    }

    // decompiled from Move bytecode v6
}

