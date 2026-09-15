module 0xf3bbf54e1a9ac839f8cce2e2f145188c94fcd01c8e7273f3cc78620694c0b8f8::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06424f454945520d426f65696572206f6e20535549bc01546865206d6f737420726573696c69656e7420747572746c65206f6e202453554920f09f92a72024424f45494552206973206275696c7420646966666572656e7420f09f90a20a0a546865204b656d70e2809973207269646c65792073656120747572746c657320646970206973207265616c202d206c6574e28099732070756d70206974206261636b20746f206c69666520217c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f626f656965725f737569227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f313836343831353936393237343637353230302f4a6437327a372d625f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

