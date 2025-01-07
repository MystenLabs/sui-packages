module 0xc30d04353777d6e21191a83f7a467869effa521b8a4c801b073d41a1b778eb38::hopcatdog {
    struct HOPCATDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCATDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPCATDOG>(arg0, 13226601472812719985, b"HOPCATDOG", b"HOPCATDOG", b"First Catdog on hop which is purely community driven", b"https://images.hop.ag/ipfs/QmW1Q8atzeqvDsmwvuS5GUDqpsesJkJ9B7XSgaTowqorxH", 0x1::string::utf8(b"https://x.com/hopCatDog"), 0x1::string::utf8(b"https://hopcatdog.com/"), 0x1::string::utf8(b"https://t.me/+PQyiNZnuig8wMWJl"), arg1);
    }

    // decompiled from Move bytecode v6
}

