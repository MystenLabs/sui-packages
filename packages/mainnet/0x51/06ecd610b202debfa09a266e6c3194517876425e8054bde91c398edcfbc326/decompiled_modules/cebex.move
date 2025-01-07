module 0x5106ecd610b202debfa09a266e6c3194517876425e8054bde91c398edcfbc326::cebex {
    struct CEBEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEBEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEBEX>(arg0, 6, b"CEBEX", b"Cebex on sui", b"$CEBEX meme token featuring a charismatic bird sui. With strength, courage, and an adventurous spirit, Kimba symbolizes leadersh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056514_95dec3182e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEBEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEBEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

