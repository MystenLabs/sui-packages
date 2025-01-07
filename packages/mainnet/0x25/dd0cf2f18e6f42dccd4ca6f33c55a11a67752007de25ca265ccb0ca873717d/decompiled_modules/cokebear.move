module 0x25dd0cf2f18e6f42dccd4ca6f33c55a11a67752007de25ca265ccb0ca873717d::cokebear {
    struct COKEBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKEBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKEBEAR>(arg0, 6, b"COKEBEAR", b"Coke Bear", b"The Bear Loves Coke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cokebearprof_81e6398368.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKEBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COKEBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

