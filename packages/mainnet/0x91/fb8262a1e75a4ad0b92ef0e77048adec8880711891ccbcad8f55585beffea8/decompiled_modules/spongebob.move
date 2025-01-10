module 0x91fb8262a1e75a4ad0b92ef0e77048adec8880711891ccbcad8f55585beffea8::spongebob {
    struct SPONGEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGEBOB>(arg0, 6, b"SPONGEBOB", b"SpongeBob Squarepants", b"Introducing SpongeBob, the new leader of the meme meta on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_d9446da14a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGEBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGEBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

