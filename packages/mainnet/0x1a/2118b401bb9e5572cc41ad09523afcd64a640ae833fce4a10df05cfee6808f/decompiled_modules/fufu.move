module 0x1a2118b401bb9e5572cc41ad09523afcd64a640ae833fce4a10df05cfee6808f::fufu {
    struct FUFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUFU>(arg0, 6, b"FuFu", b"Chinese FuFu", x"46756675206973206272696e67696e6720676f6f6420666f7274756e65212043656c65627261746520746865204c756e6172204e65772059656172207769746820746865206d6f737420617573706963696f7573206d656d65636f696e2e204d61792046756675206272696e6720796f752070726f737065726974792c206a6f792c20616e6420612079656172206f766572666c6f77696e67207769746820676f6f64206c75636b21220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_29_23_13_43_05a2bc912f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

