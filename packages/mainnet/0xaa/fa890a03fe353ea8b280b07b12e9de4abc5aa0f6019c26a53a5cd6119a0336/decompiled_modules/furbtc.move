module 0xaafa890a03fe353ea8b280b07b12e9de4abc5aa0f6019c26a53a5cd6119a0336::furbtc {
    struct FURBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURBTC>(arg0, 6, b"FURBTC", b"FURBTC ON SUI", b"FURBTC moved to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwk4dp4z7k4aabvlhvaluok6vii3kak4eydknzdxyocnekl2goai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FURBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

