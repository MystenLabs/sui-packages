module 0x180fe2dc6e9b43c0f3fcbad31e9948589322a7c5cc2887da3ad3f2837471d4e2::dragonair {
    struct DRAGONAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGONAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGONAIR>(arg0, 8, b"DRAGONAIR", b"Dragonair", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/148.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRAGONAIR>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGONAIR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGONAIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

