module 0xcbd651e2a06047d00ecc340c2cb633d77350abe6686ad18556072c0c4e6ebea3::legocat {
    struct LEGOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGOCAT>(arg0, 6, b"LegoCat", b"Lego Cat", b"The Lego Cat Memecoin is a playful cryptocurrency inspired by internet meme culture and nostalgic childhood memories of Lego toys. Its mascot is a quirky, pixelated cat designed to look like its made out of Lego bricks, featuring blocky details and vibrant colors reminiscent of classic Lego sets. This coin embraces humor and simplicity, making it popular in the meme-coin community. The Lego Cat Memecoin combines the fun appeal of memes with the collectible nature of Lego, capturing the hearts of crypto enthusiasts who enjoy lighthearted projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lego_cat_15a40ae427.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

