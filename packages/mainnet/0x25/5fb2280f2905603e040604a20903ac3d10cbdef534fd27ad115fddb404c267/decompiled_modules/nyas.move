module 0x255fb2280f2905603e040604a20903ac3d10cbdef534fd27ad115fddb404c267::nyas {
    struct NYAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAS>(arg0, 6, b"NYAS", b"NyaSUI", b"Nya from Japanese Meow :) Let's do it together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigbfycqbw3ecy6oqmd2d5wk6omxge4xyxlwpv4zczycbwff67mrpq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NYAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

