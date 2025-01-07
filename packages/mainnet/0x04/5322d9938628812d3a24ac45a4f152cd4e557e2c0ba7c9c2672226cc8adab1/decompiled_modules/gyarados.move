module 0x45322d9938628812d3a24ac45a4f152cd4e557e2c0ba7c9c2672226cc8adab1::gyarados {
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

