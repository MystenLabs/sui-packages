module 0xb3e38dee1df9ae90e184fccf67b71694a91decb90a8197bc108bbad79e5ca90a::sfm {
    struct SFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFM>(arg0, 6, b"SFM", b"Surfing Monkey", b"the adorable blue surfing monkey! With bright, fluffy fur and big, expressive eyes, he rides the waves with unmatched enthusiasm, as will ride the meme wave on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/surfing_monkey_e04f776fd0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFM>>(v1);
    }

    // decompiled from Move bytecode v6
}

