module 0x286fa1ab0488f781853890ae729de8bc6c2ba13176380a8aca95e4561c1c36dc::niggr {
    struct NIGGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGR>(arg0, 6, b"NIGGR", b"Grosse bite de noir", b"Belle bito ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_20_11_15_56_858169c702.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

