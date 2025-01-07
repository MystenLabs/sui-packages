module 0xe030a03447460949795b16dc1a1ed2cdb3fa0a416f4fda0e50169c185c6bcfdd::suishain {
    struct SUISHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHAIN>(arg0, 6, b"SUISHAIN", b"Suishain", b"When your digital coin shines so bright, even the sun needs sunglasses!  This meme captures the moment when SuiSHAIN becomes the ultimate bling in the crypto world, making all other coins look like spare change. Its the coin that not only lights up your wallet but also your day!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000239602_1bd1fa319b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

