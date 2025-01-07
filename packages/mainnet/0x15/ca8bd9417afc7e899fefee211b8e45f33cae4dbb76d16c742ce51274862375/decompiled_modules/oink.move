module 0x15ca8bd9417afc7e899fefee211b8e45f33cae4dbb76d16c742ce51274862375::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 6, b"OINK", b"Oink sui", x"205375694f494e4b20205468652070696767792d706f7765726564206d656d65636f696e210a20436f6d6d756e6974792d64726976656e207c20234d656d65436f696e207c2031303025204f494e4b2d746173746963207669626573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Oink_sui_c36cc4fccf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

