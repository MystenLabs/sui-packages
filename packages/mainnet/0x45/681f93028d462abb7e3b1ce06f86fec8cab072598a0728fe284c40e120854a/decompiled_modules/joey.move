module 0x45681f93028d462abb7e3b1ce06f86fec8cab072598a0728fe284c40e120854a::joey {
    struct JOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEY>(arg0, 6, b"Joey", b"Joey The Koala", b"Joey the koala is a tiny, adorable baby koala who spends most of his early months snuggled in his mothers pouch. At first, he is a light, soft pinkish-blue hue, hairless, and about the size of a jellybean. But as he grows, he becomes fluffy with soft gray fur and round, fuzzy ears. Joey loves to cling to his mom and slowly begins to explore the world by climbing onto her back. Hes calm, sleepy, and spends most of his time napping or munching on eucalyptus leaves once hes old enough. Joeys sweet, gentle nature makes him a symbol of cuteness!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Joey_the_koala_250x250_ea19917e17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

