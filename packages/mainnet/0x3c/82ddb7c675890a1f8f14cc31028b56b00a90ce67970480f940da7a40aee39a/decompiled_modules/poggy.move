module 0x3c82ddb7c675890a1f8f14cc31028b56b00a90ce67970480f940da7a40aee39a::poggy {
    struct POGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGGY>(arg0, 6, b"POGGY", b"POGGYSUI", x"57656c636f6d65207b6d656e74696f6e7d0a0a4c6974746c65205069672c20447265616d204269672120506f6767792069732074686520666173742d67726f77696e67206d656d6520636f6d6d756e697479206f6e205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000129550_503a45422f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

