module 0x5c8d3ab261dfb43ae01620ecfc7763795794472c67d26668a7c26a3830c76615::fourseven {
    struct FOURSEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOURSEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOURSEVEN>(arg0, 6, b"FOURSEVEN", b"$47 ON SUI", b"Welcome to 47 on Sui, the meme coin that celebrates Donald Trump as the 47th President of the United States! As we approach his inauguration, our community is buzzing with excitement and anticipation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736428012389_556164ac8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOURSEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOURSEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

