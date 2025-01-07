module 0xe1144ce2f140b562340de68f7416960d38c132bde6e89a08c3b339de13d6298f::sang {
    struct SANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANG>(arg0, 8, b"SANG", b"Suingela", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/114.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SANG>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

