module 0x7fc9d5b2febb7318335bee20c01a4b0a53fcca73c8de9669a5faae44ce3fb4b5::jj {
    struct JJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJ>(arg0, 6, b"JJ", b"JejeCoinSui", b"$JJ is a meme coin with no intrinsic value or expectation of financial return. There is no formal team or roadmap. The coin is completely useless and for entertainment purposes only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000344_424046cfc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

