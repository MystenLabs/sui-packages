module 0x4132631a98f625abeea3aaae967a0225db1efb47af4986e70d81565444af8c39::sp0x1 {
    struct SP0X1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP0X1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP0X1>(arg0, 6, b"SP0X1", b"SuiPlay0X1", x"4e617469766520746f6b656e207573656420666f722067616d6573206f6e20537569506c61793058312e0a4561726e20537569506c617920746f6b656e7320616e6420747261646564207468656d20696e20666f7220636173682e205072652d6f726465727320666f722074686520537569506c61793058312068616e6468656c647320617265206e6f77206265696e672061636365707465642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5453_b3c119e662.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP0X1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SP0X1>>(v1);
    }

    // decompiled from Move bytecode v6
}

