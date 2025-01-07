module 0x14c4029ee6c76137c37438afbb2278d366c36e2be39defa428d38cca6ea6b778::bor {
    struct BOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOR>(arg0, 6, b"BOR", b"BOR SUI", x"424f523a20426563617573652077686f20736169642066696e616e63652063616e277420626520686f672d77696c643f200a4469766520736e6f75742d666972737420696e746f2074686520776f726c64206f662063727970746f20776974682074686520666c7566666965737420776869746520626f6172206f6e2053554921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bor_logo_26fec0b1de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

