module 0xe21cf48b5113d1a78c1ea2ab2751b671de4f34a20e038e3ef4edbc04a922390a::jumpy {
    struct JUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMPY>(arg0, 6, b"JUMPY", b"Jumpy Elon", b"Introducing Jumpy Elon: The Coin That Takes Your Portfolio to New Heights!  Inspired by the legendary moment when Elon Musk couldn't resist hopping during a Donald Trump speech, Jumpy Elon is the meme coin that leaps ahead of the competition! This coin is all about having fun, jumping to the moon, and riding the waves of hype. Just like Elons unexpected bounce, Jumpy Elon is here to shake up the crypto world with quick pumps and high-flying momentum. Will it take you to the moon? Maybe Mars? One things for surethis coin is ready to jump at every opportunity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Mk_V2_Yc_Q_400x400_8602efd328.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

