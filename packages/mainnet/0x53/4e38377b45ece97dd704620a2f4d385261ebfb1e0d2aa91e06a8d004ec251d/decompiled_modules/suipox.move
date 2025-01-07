module 0x534e38377b45ece97dd704620a2f4d385261ebfb1e0d2aa91e06a8d004ec251d::suipox {
    struct SUIPOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOX>(arg0, 6, b"SUIPOX", b"Sui Pox", x"53756920506f78202824535549504f58292069732061206d656d65636f696e2077697468206120756e6971756520636f6e636570742c20696e7370697265642062792074686520696e66616d6f7573207570636f6d696e6720224d6f6e6b6579205669727573222e0a0a53756920506f78202824535549504f58292069736e2774206a757374206120636f696e69742773206120766972616c206d6f76656d656e742061696d65642061742022696e66656374696e67222070656f706c6520616e6420666f726365207468656d20746f207472616465206f6e204d6f766570756d702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_fe6a7df0d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

