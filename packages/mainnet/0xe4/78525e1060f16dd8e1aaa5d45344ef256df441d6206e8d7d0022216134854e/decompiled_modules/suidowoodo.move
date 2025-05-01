module 0xe478525e1060f16dd8e1aaa5d45344ef256df441d6206e8d7d0022216134854e::suidowoodo {
    struct SUIDOWOODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOWOODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOWOODO>(arg0, 9, b"SUIDOWOODO", b"Suidowoodo", b"suido suido", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/full/185.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDOWOODO>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOWOODO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOWOODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

