module 0x15681f10377bf5b77196dbcbb27cfa250ad4f76cd62b340b2f03f2ba8f068311::fcp {
    struct FCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCP>(arg0, 6, b"FCP", b"First Crypto President", b"Donald Trump is the first crypto president.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_14_230652_2d8ce48792.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCP>>(v1);
    }

    // decompiled from Move bytecode v6
}

