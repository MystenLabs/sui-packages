module 0x533c272e9963243bb5accb4e3f6aa3270902e32c197c84eaa30d423228a353b3::the_grumpy_cat {
    struct THE_GRUMPY_CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE_GRUMPY_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<THE_GRUMPY_CAT>(arg0, 8004923555699873672, b"TARDAR SAUCE", b"THE GRUMPY CAT", b"In loving memory of Tardar Sauce, THE GRUMPY CAT", b"https://images.hop.ag/ipfs/QmdbRxvNM3vas3oYomeDctfJBGu7iciNDXrJ9LivrxJT8p", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

