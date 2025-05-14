module 0x27a0a9d50b6ce9f734c4bfe43a8c4a59176e09a3b7abba4bed8f8812b62fc26a::stp {
    struct STP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STP>(arg0, 6, b"STP", b"Stake Trump", b"Tired of weak yields and boring meme coins? At Stake Trump, we combine the unstoppable political meme with powerful earning potential. Stake your $STP on MoonBags.io, earn bigly rewards, and become part of the most tremendous community in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifr52rrngfx3gd5razjhd2bmgaktl6sveqs45swzzxdbn6fcrrwge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

