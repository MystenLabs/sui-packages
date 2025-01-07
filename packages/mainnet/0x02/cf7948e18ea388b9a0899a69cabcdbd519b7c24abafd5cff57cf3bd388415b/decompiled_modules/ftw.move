module 0x2cf7948e18ea388b9a0899a69cabcdbd519b7c24abafd5cff57cf3bd388415b::ftw {
    struct FTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTW>(arg0, 6, b"FTW", b"Fish Tape Wall", b"Its a fish taped to a wall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_D67_B7_C3_70_CB_44_EE_90_D2_08_D034_B8_F9_CE_41b4b3311e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

