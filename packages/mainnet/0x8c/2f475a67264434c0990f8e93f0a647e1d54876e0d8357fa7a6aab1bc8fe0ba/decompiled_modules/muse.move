module 0x8c2f475a67264434c0990f8e93f0a647e1d54876e0d8357fa7a6aab1bc8fe0ba::muse {
    struct MUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSE>(arg0, 9, b"MUSE", b"MoonMuse", x"54686520746f6b656e206f6620696e737069726174696f6e20666f72206469676974616c2063726561746f72732e204d555345206675656c73204e4654206172742c20637265617469766520636f6c6c6162732c20616e64206d657461766572736520657870657269656e6365732e205468696e6b206f66206974206173206120737061726b20696e20796f75722077616c6c657420e2809420612063757272656e6379207468617420617070726563696174657320637265617469766974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/44a6803899cbcbb97126851ed8bebd33blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

