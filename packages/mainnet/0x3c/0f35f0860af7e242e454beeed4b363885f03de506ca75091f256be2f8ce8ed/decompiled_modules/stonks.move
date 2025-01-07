module 0x3c0f35f0860af7e242e454beeed4b363885f03de506ca75091f256be2f8ce8ed::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 6, b"STONKS", b"Stonksonsui", x"5468652069636f6e69632073746f6e6b73206d656d652c206e6f77206f6e20457468657265756d2e0a42652070617274206f6620746865207265766f6c7574696f6e20616e64206a6f696e20757320746f646179210a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jk_J_Ncw_C_400x400_1ec13881be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

