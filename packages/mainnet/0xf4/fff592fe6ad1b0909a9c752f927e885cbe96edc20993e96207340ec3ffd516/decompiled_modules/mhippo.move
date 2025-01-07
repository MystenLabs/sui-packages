module 0xf4fff592fe6ad1b0909a9c752f927e885cbe96edc20993e96207340ec3ffd516::mhippo {
    struct MHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHIPPO>(arg0, 6, b"MHippo", b"mhippo", b"Amidst the tranquil waters of a sunlit river, an unlikely duo embarks on a river crossing adventure. A small, mischievous monkey, full of zest, perches confidently atop the head of a massive, serene hippopotamus. The hippo, mostly submerged, provides a sturdy bridge for its tiny companion, navigating through the lush, verdant riverbanks. This scene, captured under the banner \"Embrace Adventure,\" symbolizes the spirit of cooperation and the thrill of exploring the wild, encouraging viewers to seek out and cherish the unexpected partnerships and adventures in the natural world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_4_0b2c1e66c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

