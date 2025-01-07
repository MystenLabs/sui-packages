module 0x63fec3b51364e021a6ebb1a73e6fdc31307e07b6442ca600af66d469cfa5b0c3::bow {
    struct BOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOW>(arg0, 6, b"BOW", b"'Bo'oho'o'wo'er", b"Bo'ohw'o'wo'er is a meme project on the Sui Network inspired by the viral joke of saying \"bottle of water\" in a British accent - a phrase that makes the British people the subject of playful humor everywhere they go. Embracing this global inside joke, we're building a fun community around shared laughs and cultural quirks. Join Bo'ohw'o'wo'er, and lets celebrate the lighter side of language and memes together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/736a59df_c00f_46ba_8a7e_2c7a5f2243a5_a255b8a900.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

