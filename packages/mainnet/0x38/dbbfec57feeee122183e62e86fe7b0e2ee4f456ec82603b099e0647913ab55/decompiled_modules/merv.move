module 0x38dbbfec57feeee122183e62e86fe7b0e2ee4f456ec82603b099e0647913ab55::merv {
    struct MERV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERV>(arg0, 6, b"Merv", b"Merv Sui", x"4d656d6520746f6b656e20244d4552560a4f6e6c79206f6e205355492045636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1704916647985679_df7762f4b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERV>>(v1);
    }

    // decompiled from Move bytecode v6
}

