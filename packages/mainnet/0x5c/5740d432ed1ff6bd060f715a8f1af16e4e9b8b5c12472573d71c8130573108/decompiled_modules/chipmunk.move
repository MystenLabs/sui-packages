module 0x5c5740d432ed1ff6bd060f715a8f1af16e4e9b8b5c12472573d71c8130573108::chipmunk {
    struct CHIPMUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPMUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHIPMUNK>(arg0, 6, b"CHIPMUNK", b"CHIPMUNK", b"SuiEmoji Chipmunk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/chipmunk.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIPMUNK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPMUNK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

