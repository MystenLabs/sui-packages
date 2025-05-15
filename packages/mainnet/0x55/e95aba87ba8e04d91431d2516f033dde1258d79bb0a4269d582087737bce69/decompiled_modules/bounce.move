module 0x55e95aba87ba8e04d91431d2516f033dde1258d79bb0a4269d582087737bce69::bounce {
    struct BOUNCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOUNCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOUNCE>(arg0, 6, b"BOUNCE", b"This Will Bounce", b"this will bounce (bounce)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052856_25e0d75158.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOUNCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOUNCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

