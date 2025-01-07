module 0x1095550a7fb7b9947965dd30a16727ca26572ed6aa12c26743a8d4c546d52261::smoodeng {
    struct SMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOODENG>(arg0, 6, b"SMOODENG", b"MOODENG ON SUI", x"4d4f4f44454e4720697320746865206d6f73742066616d6f757320686970706f20696e2074686520776f726c6420616e6420686173206170706561726564206f6e2074686520535549206e6574776f726b2e20446f6e2774206d697373206f7574206f6e207468697320706f74656e7469616c20636f696e210a24534d4f4f44454e4720746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2_2f487d1658.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

