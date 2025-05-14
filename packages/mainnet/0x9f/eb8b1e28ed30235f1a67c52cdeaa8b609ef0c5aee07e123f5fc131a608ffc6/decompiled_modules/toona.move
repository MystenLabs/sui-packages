module 0x9feb8b1e28ed30235f1a67c52cdeaa8b609ef0c5aee07e123f5fc131a608ffc6::toona {
    struct TOONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOONA>(arg0, 6, b"TOONA", b"toona swimming", b"lil fish swimming in the sea...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigthrk4tdgprul3rub5xxf5z33x7t6imc4jeuxlxlwgi7repepj7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOONA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

