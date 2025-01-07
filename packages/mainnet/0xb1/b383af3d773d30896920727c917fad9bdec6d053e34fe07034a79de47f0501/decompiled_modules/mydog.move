module 0xb1b383af3d773d30896920727c917fad9bdec6d053e34fe07034a79de47f0501::mydog {
    struct MYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYDOG>(arg0, 6, b"Mydog", b"my dog in fukin sui", x"4865206973204d6f7267616e2c206865206973203131207965617273206f6c6420616e642061742035206865206c6f6f6b6564206c696b6520746869732c206275792074686520746f6b656e20736f20492063616e206275792068696d20666f6f642c20696620796f752077616e74206f6e20736f6369616c206e6574776f726b732061736b206d6520666f7220766964656f7320616e642070686f746f73206f66204d6f7267616e2c207468616e6b20796f7520636f6d6d756e6974790a4c6574277320726f636b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mi_dog_in_fuckin_sui_aa374d3f45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

