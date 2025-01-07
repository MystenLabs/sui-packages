module 0xf57713c49f9664c94d9e7bbbe37bb71f4ff3021f74e0e50b09f582d6fb8e6c81::gyarados {
    struct GYARADOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYARADOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYARADOS>(arg0, 9, b"GYARADOS", b"Gyarados", b"The legendary Gyarados on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full/130.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GYARADOS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYARADOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GYARADOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

