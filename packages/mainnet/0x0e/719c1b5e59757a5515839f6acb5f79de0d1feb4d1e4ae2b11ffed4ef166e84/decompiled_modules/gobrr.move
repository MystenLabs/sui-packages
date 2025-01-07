module 0xe719c1b5e59757a5515839f6acb5f79de0d1feb4d1e4ae2b11ffed4ef166e84::gobrr {
    struct GOBRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBRR>(arg0, 6, b"GOBRR", b"GO BRR", b"GO BRR or GO HOME Innovative Meme Project driven by community success Each market cap milestone unlock a deliverable The more you BRR the more we build !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1_da73a456d8_360c774674.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

