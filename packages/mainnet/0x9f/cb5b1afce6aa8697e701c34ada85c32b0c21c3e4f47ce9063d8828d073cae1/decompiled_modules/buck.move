module 0x9fcb5b1afce6aa8697e701c34ada85c32b0c21c3e4f47ce9063d8828d073cae1::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 9, b"BUCK", b"Buck The Pup", b"Buck is the cutest pup on sui, on a mission to send $Buck to a Buck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FQmc46_Zz9_WDL_Rpzfk73ft_X_Xjp_Vkv_Rr8vx_NN_Qrh_Qi_Es_P7r3_W_0a998da396.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUCK>(&mut v2, 200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK>>(v2, @0x5c9bb147d9ed48100b208a900ab1f8777035fd303522c941d06d5fbc25d68021);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

