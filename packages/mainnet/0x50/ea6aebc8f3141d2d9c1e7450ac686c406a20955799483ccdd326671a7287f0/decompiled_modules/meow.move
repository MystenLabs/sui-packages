module 0x50ea6aebc8f3141d2d9c1e7450ac686c406a20955799483ccdd326671a7287f0::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"Meowcoin", x"4d656f77436f696e206973206e6f74206a7573742061206d656d65636f696e2c2062757420616c736f206861732061206d697373696f6e20746f2073707265616420746865206a6f7920616e6420637574656e657373206f66206361747320746f207468652063727970746f20636f6d6d756e6974792e20497420697320706f737369626c6520746f206275696c6420616e2065636f73797374656d20776974683a0ae280a22046756e6e7920636174204e465473200ae280a220436861726974792066756e6420746f2068656c702073747261792063617473200ae280a2204361742d7468656d656420503245", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/c7ffbe5a-1403-465c-824b-030875a41269.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

