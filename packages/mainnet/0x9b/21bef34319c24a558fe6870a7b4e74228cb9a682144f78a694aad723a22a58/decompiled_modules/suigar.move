module 0x9b21bef34319c24a558fe6870a7b4e74228cb9a682144f78a694aad723a22a58::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 6, b"SUIGAR", b"SUIGAR POKEMOON", b"SUIGAR the first pokemoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewzbievfvnljpvgv3ugqpjotientmrrji3z5jiiflaprvqjyezae")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

