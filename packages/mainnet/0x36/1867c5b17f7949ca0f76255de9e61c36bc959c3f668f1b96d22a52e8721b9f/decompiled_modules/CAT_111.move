module 0x361867c5b17f7949ca0f76255de9e61c36bc959c3f668f1b96d22a52e8721b9f::CAT_111 {
    struct CAT_111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT_111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT_111>(arg0, 6, b"CAT_111", b"CAT", b"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmZtneTQy4HqqvT4jtEGLkMX7JXpTBzfXjmxd1Tr85PJme")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT_111>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT_111>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

