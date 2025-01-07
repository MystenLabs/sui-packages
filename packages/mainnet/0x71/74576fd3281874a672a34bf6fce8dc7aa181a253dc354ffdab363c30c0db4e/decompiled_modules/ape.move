module 0x7174576fd3281874a672a34bf6fce8dc7aa181a253dc354ffdab363c30c0db4e::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"Ape Wizard", x"4170652057697a6172642069732061206d7973746963616c206d656d6520636f696e20696e73706972656420627920746865206c6567656e64617279207370656c6c2d63617374696e67206d6f6e6b657920746861742061707065617273206f6e2048616c6c6f7765656e206e696768742e205468697320746f6b656e2061696d7320746f206272696e67206120746f756368206f66206d6167696320616e64206d79737465727920746f207468652053554920776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd8f_Lajvedur_H_Ms_An8k_Lf_JL_Sf_Ejrd_Y_Bt_NWRLT_6h_Y_Le4_Uc_cc6125fb64.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APE>>(v1);
    }

    // decompiled from Move bytecode v6
}

