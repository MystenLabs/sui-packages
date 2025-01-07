module 0xffa249f2341238b81a5b789f0aca028db4e53a296983386b612a9caa9159f03c::pensui {
    struct PENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENSUI>(arg0, 6, b"PENSUI", b"PENSIVE FISH", x"57656c636f6d6520746f2050656e7369766520466973682c746865206d656d65636f696e20746861742773206d6f76696e672074686520776f726c6420210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_00_00_53_96eefe07d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

