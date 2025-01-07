module 0x8bb3ea50b006faae5275a7522cddce85c1dc4dde7e59094caa37ef860ccd6eb5::ayps {
    struct AYPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYPS>(arg0, 6, b"AYPS", b"Are ya printing, son?", b"The phrase \"Are ya printing, son?\" is a humorous twist on the meme \"Are you winning, son?\" Picture a dad peeking into a room where his kid is deep in crypto mining or day trading,seemingly conjuring money out of thin air. The question playfully captures the excitement and absurdity of the digital gold rush, where pixels turn into profits and every beep of the computer might signal a windfall. Its a cheeky nod to how the hustle has gone high-tech, blending the thrill of gaming with the allure of a get-rich-quick scheme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_97af2d3c9c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

