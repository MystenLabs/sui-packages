module 0x3a9d02fddcfc975df8b86c8f0679df5384366be7be902e818cc0a8e3dc6d4062::fwug {
    struct FWUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWUG>(arg0, 6, b"FWUG", b"FWUGSUI", b"FWUG TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r30_K5oz_V_400x400_1_c69544551a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

