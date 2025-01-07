module 0x64400296b3286e09f54dc0705f44ade5577ecbfde816a371e4d06ac2413a3f77::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 9, b"APE", b"apple", x"4269746520696e746f20746865206675747572652077697468204170706c65436f696e3a2054686520637269737020616e642072656672657368696e672063727970746f63757272656e6379207468617427732068617276657374696e67206a756963792070726f6669747320616e64206b656570696e67207468652063727970746f20776f726c6420667265736820f09f8d8f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a6e18e6-8dbe-4993-904f-bdc0a3c6cdeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APE>>(v1);
    }

    // decompiled from Move bytecode v6
}

