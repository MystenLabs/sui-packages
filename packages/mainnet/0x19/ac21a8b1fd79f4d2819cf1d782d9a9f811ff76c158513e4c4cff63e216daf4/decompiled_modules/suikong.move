module 0x19ac21a8b1fd79f4d2819cf1d782d9a9f811ff76c158513e4c4cff63e216daf4::suikong {
    struct SUIKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKONG>(arg0, 6, b"SUIKONG", b"SuiWukong", x"53756957756b6f6e6720697320496d7072657373697665204141412067616d652066726f6d204368696e61210a53756957756b6f6e67206973206d6f6e6b6579206d656d6520636f6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048300_b4dc20ad6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

