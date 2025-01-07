module 0xfd994ca310e8908b045798153cb7e42c5a1aff3336dae73f5d95e3da3aa2b48c::tapswap {
    struct TAPSWAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAPSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAPSWAP>(arg0, 6, b"TAPSWAP", b"tapswap", b"to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032842_9165bc9f72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPSWAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAPSWAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

