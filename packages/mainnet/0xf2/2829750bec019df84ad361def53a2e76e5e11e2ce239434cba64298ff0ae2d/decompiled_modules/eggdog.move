module 0xf22829750bec019df84ad361def53a2e76e5e11e2ce239434cba64298ff0ae2d::eggdog {
    struct EGGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGDOG>(arg0, 6, b"EGGDOG", b"EGGDOGSUI", b"Eggdog is a super cute and quirky internet meme that's shaped like an egg but has the heart of a dog.  It first appeared in a video titled \"Meet Eggdog\" by YouTuber Zamsire back in March 2019 and quickly won over the internet with its unique charm. Eggdog is known for its fun antics, like stretching super high into the air or breaking into a happy dance.  It's all about spreading positivity, eggcitement, and a love for baguettes and strawberries!  And guess what? Eggdog has even made its way into the crypto world with its own token on the Sui blockchain. How eggciting is that? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEME_1427a31b86.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

