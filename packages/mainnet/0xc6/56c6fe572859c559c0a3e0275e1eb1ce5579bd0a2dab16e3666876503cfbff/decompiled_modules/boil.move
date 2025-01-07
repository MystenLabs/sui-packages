module 0xc656c6fe572859c559c0a3e0275e1eb1ce5579bd0a2dab16e3666876503cfbff::boil {
    struct BOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOIL>(arg0, 6, b"BOIL", b"CRAB BOIL", b"Why should you buy this Crab Meme Picture? Imagine owning a piece of internet culture that encapsulates the essence of humor and relatability in one quirky crustacean image. This isn't just any picture; it's a conversation starter, a mood setter, and a testament to your savvy understanding of meme culture. Whether you're decorating your digital space, looking for the perfect gift for that friend who lives for memes, or simply want to print it out as a quirky piece of wall art, this crab meme offers versatility in its appeal. It's not just about the laughs; it's about being part of a community that gets the inside joke. Plus, it's an investment in joy  each time you or someone else glances at it, you're guaranteed a chuckle or a knowing nod. In a world that can often be too serious, this crab meme is your daily dose of levity, making it not just a purchase, but a smart choice for enhancing your life with a bit of fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crab_boil_56002e0b61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

