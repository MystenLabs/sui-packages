module 0x8a42b33b381254c633039f1c3ff66c1ebbacd749456d5fb753b7978b0198c293::MINIBOT {
    struct MINIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIBOT>(arg0, 6, b"MiniBotBucks", b"MINIBOT", b"The ultimate meme coin for robot enthusiasts! MiniBotBucks fuels your love for tiny, adorable robots with a fun, community-driven token. Join the MiniBot revolution and let's automate the meme economy together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/k9I4oDDndw4iLpf6NFY8S9diZyYHKTmIBFjuec5bc3WZnfLqA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIBOT>>(v0, @0xbdebc33436425c9a7ca66a3b35925621c8885d16b3c741b9ca39527620462511);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

