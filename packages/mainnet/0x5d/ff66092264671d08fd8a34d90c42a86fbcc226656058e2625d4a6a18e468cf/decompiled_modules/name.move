module 0x5dff66092264671d08fd8a34d90c42a86fbcc226656058e2625d4a6a18e468cf::name {
    struct NAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAME>(arg0, 6, b"NAME", b"Ning-Sui", b"Hi, I'm  Ning-Sui. Im a biologist that studies sea plants. I would love to help you 100x your Sui, no pun intended. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ning_sui_4b73920484.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

