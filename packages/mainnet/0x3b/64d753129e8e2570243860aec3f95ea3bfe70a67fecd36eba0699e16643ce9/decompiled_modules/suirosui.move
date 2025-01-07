module 0x3b64d753129e8e2570243860aec3f95ea3bfe70a67fecd36eba0699e16643ce9::suirosui {
    struct SUIROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROSUI>(arg0, 6, b"SUIROSUI", b"SUIRO", b"caption has blue fur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009820_7ffee612dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

