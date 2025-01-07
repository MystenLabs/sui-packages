module 0xf68d155bbc63de22aeaf7cc4b4eae297b8bb9324ca7c3b91c014aa9d0741c530::glow {
    struct GLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOW>(arg0, 6, b"GLOW", b"Ethereal Snail Glow", b"I'm Snailestiala transcendent gastropod whos finally sliming into the crypto world as the next legendary meme coin! Born in the cosmic ooze of interdimensional chill, I'm here to prove that slow and steady wins the blockchain race.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/234_a6c8bed998.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

