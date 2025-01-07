module 0x9781677b983e24b012774eb573cfbc69666d88cabab5a2c2716e75a3e6f4d641::pepepig {
    struct PEPEPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEPIG>(arg0, 6, b"PEPEPIG", b"Pepe Pig", b"The family-friendly crypto meme sensation  $PEPEPIG! Finally, a coin the whole fam can cheer for (yes, even Grandma might get in on this one). Gather the kids, tell the wife, and prep the snacks: were heading to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepepigicon_2x_ffcba762b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

