module 0x8099310d13aa6f8b8a4c88d3395e7846a26ad15987598bbb030ce98b82c476ad::POW {
    struct POW has drop {
        dummy_field: bool,
    }

    fun init(arg0: POW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POW>(arg0, 6, b"MemeFighters", b"POW", b"A meme coin for the ultimate meme battle arena! MemeFighters ($POW) lets you stake your favorite memes and vote in epic meme wars. The strongest meme survives and earns rewards. Join the fight and prove your meme is the dankest!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/5QFO5NLrIIqyLpkHBuGJgbSUuxl17r0uQTWRMLr4KH2qvfiKA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POW>>(v0, @0xdfbc0bca5f7ab287e65359124a2abf5cad98f8b6b7624819a650050338195689);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POW>>(v1);
    }

    // decompiled from Move bytecode v6
}

