module 0xb04948753e2a2946d358487ff047e3623fff5ce8e7c02d59da1b706b7f52adaa::suibara {
    struct SUIBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBARA>(arg0, 6, b"SUIBARA", b"SUIBARA SUI", b"Suibara is a fun and innovative meme coin that celebrates the lovable Suibara, known for its friendly demeanor and social nature. We believe in building a community where everyone can enjoy the lighter side of cryptocurrency while making meaningful connections.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043376_0217cfd974.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

