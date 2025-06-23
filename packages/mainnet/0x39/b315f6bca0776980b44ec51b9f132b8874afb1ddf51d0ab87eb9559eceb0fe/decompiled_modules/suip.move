module 0x39b315f6bca0776980b44ec51b9f132b8874afb1ddf51d0ab87eb9559eceb0fe::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"Suipson", b"Straight from Springfield to the blockchain meet Suipson  The perfection found between the yellow universe of The Simpsons and the power of the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7bcgq2jvaqc75ekhg3am3bwrvncg4ew6lvtz7ra6eob44g6twia")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

