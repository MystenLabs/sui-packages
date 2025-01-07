module 0x4fc9c6516a6873e960d0704310d2c5bec0e2b35fc841ea729ee9889fc0ff63a2::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 6, b"OINK", b"Sui OINK", b"OINK OINK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067748_ef9914fd7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

