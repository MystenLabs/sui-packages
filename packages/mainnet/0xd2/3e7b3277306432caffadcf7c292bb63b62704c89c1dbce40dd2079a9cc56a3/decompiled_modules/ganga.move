module 0xd23e7b3277306432caffadcf7c292bb63b62704c89c1dbce40dd2079a9cc56a3::ganga {
    struct GANGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGA>(arg0, 6, b"GANGA", b"Gangar", b"The Ghostliest Meme Token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib4kfbqrcayqtzkkcb4pxs3ofnkkncfievybeduhqw3j5yrt6zfg4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GANGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

