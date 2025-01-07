module 0xf6f807aa056ec67733e7cfb3fbe94628fb2218f3216db5316c0928f9000ddec8::dice {
    struct DICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICE>(arg0, 6, b"DICE", b"$DICE", b"$Dice is a blockchain-based token designed to revolutionize online gambling with a focus on dice games.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wnt_Js_Xjf_400x400_10bc6aa499.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

