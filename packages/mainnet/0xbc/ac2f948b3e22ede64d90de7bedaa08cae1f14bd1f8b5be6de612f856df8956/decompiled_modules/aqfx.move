module 0xbcac2f948b3e22ede64d90de7bedaa08cae1f14bd1f8b5be6de612f856df8956::aqfx {
    struct AQFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQFX>(arg0, 9, b"AQFX", b"AquaFox", b"AquaFox Coin is a groundbreaking meme token built on the SUI blockchain. Inspired by the agility and elegance of blue foxes, AquaFox combines innovation with entertainment, aiming to connect digital communities with real-world value. AquaFox is not just another meme coin; it introduces a gamified ecosystem where users can earn rewards, stake their tokens, and engage in blockchain-based games. With a focus on simplicity and fun, AquaFox aims to revolutionize the way we perceive and interact with meme tokens in the Web3 space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fc30b432cb6512675826e9af7a5bb027blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQFX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQFX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

