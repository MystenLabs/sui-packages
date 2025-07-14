module 0xcfcb2a5e94f29d09705599a8bd0a05bfa2071d0af244d73dd314709bc1d0c24b::xsui {
    struct XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI>(arg0, 6, b"Xsui", b"Samuraix", b"SamuraiX is not just another meme coin. It's a movement inspired by the legendary code of the samurai: honor, loyalty, and precision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicbfntdjcm7mia4bq5rgady64mb4awxikvefmzzzfeuddiddcpkai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

