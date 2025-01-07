module 0x8972d25897e9cede3243e886885313e38f2bc2352005ffddc988380a448d91a8::tusdt {
    struct TUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSDT>(arg0, 6, b"TUSDT", b"Tetherbear usdt", x"20546865204d656d65205265766f6c7574696f6e204261636b6564206279205375690a200a4120426f6c64204e657720457261206f66204d656d6520436f696e730a496e206120776f726c64207768657265206d61726b657473206172652064726976656e206279206d656d65732c20636f6d6d756e69746965732c20616e6420687970652c74657468657262656172757364742072697365732061732061206e6577205472656e6420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0012_30c652a831.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

