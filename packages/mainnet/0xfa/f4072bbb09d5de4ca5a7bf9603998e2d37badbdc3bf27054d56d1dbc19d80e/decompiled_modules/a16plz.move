module 0xfaf4072bbb09d5de4ca5a7bf9603998e2d37badbdc3bf27054d56d1dbc19d80e::a16plz {
    struct A16PLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: A16PLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A16PLZ>(arg0, 6, b"A16plz", b"A number 16 please", x"5468616e6b20796f7520666f722063686f6f73696e67204d63446f6e616c6427732e20576861742063616e204920676574207374617274656420666f7220796f7520746f6461793f2041206e756d6265722031363f2054686174276c6c206265202431382e39390a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_A3y_GXV_8_Fu_Pg_E6_H5_N6qb_M2u1fd_Ta_XP_1tyz8_B2x_XE_Ffs_Q_f79017103a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A16PLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A16PLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

