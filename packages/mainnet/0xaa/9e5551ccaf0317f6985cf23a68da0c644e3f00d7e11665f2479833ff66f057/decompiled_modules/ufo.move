module 0xaa9e5551ccaf0317f6985cf23a68da0c644e3f00d7e11665f2479833ff66f057::ufo {
    struct UFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFO>(arg0, 6, b"UFO", b"UFO Pepe", x"0a2455464f20697320746865206c6174657374206d656d65636f696e2073656e736174696f6e206f6e20535549212041726520796f752066617363696e617465642062792055464f733f20446f20796f752068617665206120736f66742073706f7420666f72206d656d65636f696e733f20576527766520676f7420746865207065726665637420626c656e6420666f7220796f752120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gea_S_Jqo_WYA_Aj_B8_G_9537fbaca3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

