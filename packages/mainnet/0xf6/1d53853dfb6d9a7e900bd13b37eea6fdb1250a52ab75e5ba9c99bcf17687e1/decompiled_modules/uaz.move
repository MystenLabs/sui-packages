module 0xf61d53853dfb6d9a7e900bd13b37eea6fdb1250a52ab75e5ba9c99bcf17687e1::uaz {
    struct UAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: UAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAZ>(arg0, 6, b"UAZ", b"UAZ BUKHANKA", b"UAZ BUKHANKA Token is the ultimate fusion of off-road adventure and meme culture, built on the Sui blockchain. Inspired by the iconic UAZ \"Bukhanka\" van, this meme token embodies rugged durability with a humorous twist, celebrating the quirky and enduring spirit of both the van and the blockchain community. UAZ BUKHANKA is designed for those who appreciate a good laugh while embracing the future of decentralized finance. Whether you're cruising through the crypto markets or bouncing over the bumps of meme trends, UAZ BUKHANKA is here for the ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uzalogo1_92109202de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

