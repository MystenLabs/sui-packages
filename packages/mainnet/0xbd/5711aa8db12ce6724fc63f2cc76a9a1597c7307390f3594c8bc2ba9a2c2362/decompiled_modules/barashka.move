module 0xbd5711aa8db12ce6724fc63f2cc76a9a1597c7307390f3594c8bc2ba9a2c2362::barashka {
    struct BARASHKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARASHKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARASHKA>(arg0, 6, b"BARASHKA", b"Barashka", b"!!! im BARASHKA  the most viral ram on TikTok. my farmer says I'm the cutest  and most narcissistic creature in the world. i agree with him a hundred fucking percent!!!! so who but me must fulfil a sacred purpose? lets MAKE MEMECOINS CUTE AGAIN . Together!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/121221212_1e51c8e66a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARASHKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARASHKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

