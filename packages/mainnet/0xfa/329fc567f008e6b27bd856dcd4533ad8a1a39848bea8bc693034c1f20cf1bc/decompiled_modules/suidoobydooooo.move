module 0xfa329fc567f008e6b27bd856dcd4533ad8a1a39848bea8bc693034c1f20cf1bc::suidoobydooooo {
    struct SUIDOOBYDOOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOOBYDOOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOOBYDOOOOO>(arg0, 6, b"SuiDoobyDooOOO", b"Sui Doo", b", an animation of a dog's life from being a puppy  to adulthood, it's innocence , curiosity, mischievousness as well as how protective  it can be when it comes to family all in one , that's right family! that's our goal to create a family...a community that noone can stand between and  Sui Doo can and make it happen. The Meme that will last a lifetime.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_5_6b55a962f6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOOBYDOOOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOOBYDOOOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

