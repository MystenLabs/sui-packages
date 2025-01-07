module 0xeec4fdd1cb02a36a145d0ae3e8305697213daa3f4732e46f5e22da34b9077993::img {
    struct IMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IMG>(arg0, 6, b"IMG", b"ImageCoin by SuiAI", b"The scalable decentralized digital currency shaping the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4890dcdc_2676_437a_afff_b02625f41262_388ff0996c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

