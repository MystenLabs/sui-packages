module 0x4920b1bb8697fa7af06c031c0abc8c72a4466b3e53c6e619f29a61169b3d28b6::kdx {
    struct KDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDX>(arg0, 9, b"KDX", b"Kriya DEX", x"4275696c64696e6720696e20706561636520f09fa798e2808de29982efb88f206275696c64696e67206f6e2073756920f09f92a72073776170207c206c696d6974206f7264657273207c20312d636c69636b207969656c642073747261746567696573207c20323078207065727073207c2065766572797468696e6720666f722065766572796f6e65206170702e6b726979612e66696e616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1799980607532908545/gpmbmcrK_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KDX>>(0x2::coin::mint<KDX>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KDX>>(v2);
    }

    // decompiled from Move bytecode v6
}

