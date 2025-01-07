module 0x9cbf50c69d46528c00927145e17d6f39690ab9fc0bfee06dc6a1ef0d5e3c2d5d::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"BITCOIN TRADER CAT", b"$BTC - THE BITCOIN TRADER CAT , WHO LIKES TO SMOKE WEED AND DRINK BEER, IT CAN BE SEEN BY HIS FAT ASS, STUPID NOOB FACE, PUPPET FARM CAT BUS IS HERE TO ROCK !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_14_08_24_ca9563dd44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

