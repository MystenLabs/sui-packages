module 0x50bd1c0a02974b593440caa9bb02d41abc0f578b5e31c2f01a273556c05d769b::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 8, b"KING", b"Nidoking", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full/034.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KING>(&mut v2, 30000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KING>>(v1);
    }

    // decompiled from Move bytecode v6
}

