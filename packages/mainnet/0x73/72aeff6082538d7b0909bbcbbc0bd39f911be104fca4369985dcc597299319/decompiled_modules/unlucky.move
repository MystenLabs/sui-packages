module 0x7372aeff6082538d7b0909bbcbbc0bd39f911be104fca4369985dcc597299319::unlucky {
    struct UNLUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNLUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNLUCKY>(arg0, 6, b"UNLUCKY", b"UNLUCKY SUI", x"5365746261636b732061726520594f5552207374657070696e672073746f6e657320746f2067726561746e657373202620747269756d70682e20456d6272616365207468656d20776974682068756d6f72202620706f73697469766974792026206769766520656d20796f7572200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Fy_JE_Itd_400x400_82432effb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNLUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNLUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

