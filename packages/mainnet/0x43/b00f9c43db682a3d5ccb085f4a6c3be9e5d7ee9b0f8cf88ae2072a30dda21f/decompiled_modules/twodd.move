module 0x43b00f9c43db682a3d5ccb085f4a6c3be9e5d7ee9b0f8cf88ae2072a30dda21f::twodd {
    struct TWODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWODD>(arg0, 6, b"TWODD", b"TWODD SUI", x"2454776f646420746865207265616c205361746f73686920696e207468652046776f6720756e697665727365200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A9_Sqohk_F_400x400_31a9b0e506.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

