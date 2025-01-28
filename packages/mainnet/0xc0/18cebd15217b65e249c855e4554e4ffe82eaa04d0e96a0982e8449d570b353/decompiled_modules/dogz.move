module 0xc018cebd15217b65e249c855e4554e4ffe82eaa04d0e96a0982e8449d570b353::dogz {
    struct DOGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGZ>(arg0, 6, b"DOGZ", b"Dogz", b"DOGZ is more than just a cryptocurrencyit's a cultural phenomenon. Inspired by the internets love for memes and the unstoppable charm of dog-themed tokens, DOGZ brings humor and financial opportunities together in a single token. Whether you're a seasoned trader or a meme enthusiast, DOGZ offers a vibrant community and an unforgettable crypto experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250127_190010_4eb37b3a6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

