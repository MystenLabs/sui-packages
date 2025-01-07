module 0x7d6807bbe509e6a47b500e6e9bad8e7ce45f77762e270e27fa6379fc0f633811::eggi {
    struct EGGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGI>(arg0, 6, b"EGGI", b"EGGI ON SUI", b"Eggi is a cryptocurrency meme coin that depicts an egg that you can never break ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042369_e49260f434.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

