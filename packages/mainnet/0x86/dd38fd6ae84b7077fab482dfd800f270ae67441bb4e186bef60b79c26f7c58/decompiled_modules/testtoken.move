module 0x86dd38fd6ae84b7077fab482dfd800f270ae67441bb4e186bef60b79c26f7c58::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 0, b"TESTTOKEN", b"Test Token", x"466f7267657420746865206472616d612c206a6f696e20746865205465737420546f6b656e2065726121204974277320746865206f6e6c792074696d6520796f752063616e2074657374206265666f726520746865207265616c2066756e20e280932072656d656d62657220746f20484f444c206c696b65206974e28099732061206d656d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://v3.fal.media/files/panda/poTgdFNLD6T16ecEJsoeY.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTTOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

