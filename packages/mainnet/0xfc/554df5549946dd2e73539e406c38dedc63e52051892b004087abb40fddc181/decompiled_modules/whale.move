module 0xfc554df5549946dd2e73539e406c38dedc63e52051892b004087abb40fddc181::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Whale by Matt Furies", x"4d616b6520612073706c6173682077697468205748414c452c2074686520636f696e20746861742773207375726520746f206d616b6520776176657320696e20796f7572205375692077616c6c657421204469766520696e746f20746865206f6365616e206f662063727970746f2077697468206f757220676967616e74696320746f6b656e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe6d7c2c238df4cbcc04429c19302f9e326f0ca9b_061529f95f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

