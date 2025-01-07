module 0x6806a82629d00646c1cb75b59a33c3bdbf902071c60af96f911e301c45aa4fb7::suidick {
    struct SUIDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDICK>(arg0, 6, b"SUIDICK", b"Dick On Sui", b"Wait theres a dick meta going on? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044165_9fd7487adc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

