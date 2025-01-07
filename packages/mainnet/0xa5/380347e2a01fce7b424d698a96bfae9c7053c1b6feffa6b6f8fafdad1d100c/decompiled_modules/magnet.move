module 0xa5380347e2a01fce7b424d698a96bfae9c7053c1b6feffa6b6f8fafdad1d100c::magnet {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET>(arg0, 6, b"MAGNET", b"SUI MAGNET", b"Magnet is a meme coin inspired by Mr. Murad's story, who turned a $2 million loss into a $25 million comeback through meme coins. Magnet aims to empower the community to grow stronger, achieve wealth, and gain financial freedom. Its about turning setbacks into success and helping the meme coin community thrive together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_at_19_47_30_a3e8f1143d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

