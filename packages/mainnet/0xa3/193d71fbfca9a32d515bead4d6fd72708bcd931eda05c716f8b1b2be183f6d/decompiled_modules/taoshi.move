module 0xa3193d71fbfca9a32d515bead4d6fd72708bcd931eda05c716f8b1b2be183f6d::taoshi {
    struct TAOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOSHI>(arg0, 6, b"TAOSHI", b"TAOSHI_SUI", b"$TAOSHI _SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0w_Ye_Bcj3_400x400_4f461af603.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

