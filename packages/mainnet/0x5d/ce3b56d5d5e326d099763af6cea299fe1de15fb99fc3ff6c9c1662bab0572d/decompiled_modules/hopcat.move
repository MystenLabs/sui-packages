module 0x5dce3b56d5d5e326d099763af6cea299fe1de15fb99fc3ff6c9c1662bab0572d::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPCAT>(arg0, 14888421236251059136, b"HopCat", b"$HopCat", b"First cat on Hop Fun", b"https://images.hop.ag/ipfs/QmWgvj3yw9AhXjDiDcS3tusixMAjTwE7LdxAKaPAFgXoQK", 0x1::string::utf8(b"https://x.com/HopCatSui"), 0x1::string::utf8(b"https://hopcat.fun/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

