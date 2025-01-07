module 0xe097a68d90ad6503c684a75bd50d10988f5a1792dfa9dd2eee87a37f7e9bcb83::winu {
    struct WINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINU>(arg0, 6, b"WINU", b"Wrapped Inu", b"if i reach 1B,i won't feel cold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_0c1edb569a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

