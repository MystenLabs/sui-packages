module 0xa1ed8f764c76d82c2170851811ac431e6d754dece0f6124d1bfcfa7f83d63147::lpp {
    struct LPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPP>(arg0, 6, b"LPP", b"Sui Lampapuy", x"537569204c616d7061707579202d2074686520466972737420436f6d6d756e697479206f776e65642050726f6a6563740a537569204c616d7061707579206973207468652077617920746f20657870726573732068756d6f722c20637265617469766974792c20616e6420736f6369616c20636f6d6d656e74617279207468726f75676820244c5050200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_09_03_31_22_da62722976.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

