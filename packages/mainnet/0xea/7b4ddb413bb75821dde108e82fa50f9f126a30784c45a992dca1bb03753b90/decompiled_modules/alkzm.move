module 0xea7b4ddb413bb75821dde108e82fa50f9f126a30784c45a992dca1bb03753b90::alkzm {
    struct ALKZM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALKZM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALKZM>(arg0, 9, b"ALKZM", b"Alakazam", b"Alakazam Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.pokemoncentral.it/wiki/thumb/f/f9/Artwork0065_RFVF.png/400px-Artwork0065_RFVF.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALKZM>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALKZM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALKZM>>(v1);
    }

    // decompiled from Move bytecode v6
}

