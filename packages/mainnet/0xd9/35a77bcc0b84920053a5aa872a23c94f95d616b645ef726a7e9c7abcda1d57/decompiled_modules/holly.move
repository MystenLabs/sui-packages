module 0xd935a77bcc0b84920053a5aa872a23c94f95d616b645ef726a7e9c7abcda1d57::holly {
    struct HOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLLY>(arg0, 6, b"HOLLY", b"Holly Cat", b"Holly Cat  is the purrfect meme coin to bring some fun into your crypto life!  With a playful spirit and a cheeky personality, it's ready to make waves in the crypto community.  Whether you're a cat lover  or just looking for a fun investment, Holly Cat is here to make your day a little more pawsitive.  Join the cat craze and watch your portfolio climb!  #HollyCatCoin #CryptoPaws #CatPower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_28_1_cfecfd9552.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

