module 0x429350e01d0f8a75735544bda16ac951d9aca6e5fdafcd1fb3957476de835ead::oni {
    struct ONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ONI>(arg0, 16715941285416492361, b"Devil Oni", b"ONI", b"In Japanese folklore, Oni are demons or ogres. They are typically large and scary-looking with red or blue skin, horns, and sharp claws. They are known for their strength and love to cause trouble. Sometimes, they are even said to eat people!", b"https://images.hop.ag/ipfs/QmcrmJ3GUG6kwmT5FDRkFRccUgfDCcUDWmcUcQaGuX5zx6", 0x1::string::utf8(b"https://x.com/thedeviloni"), 0x1::string::utf8(b"https://deviloni.com/"), 0x1::string::utf8(b"https://t.me/thedeviloni"), arg1);
    }

    // decompiled from Move bytecode v6
}

