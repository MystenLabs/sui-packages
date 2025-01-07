module 0xb91f7054794e4ddf1e250622753a82f7cbfc037cbc4af10cdc6b4ee62a0a4050::blas {
    struct BLAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAS>(arg0, 9, b"BLAS", b"Blastoise", b"Aumenta de peso deliberadamente para contrarrestar la fuerza de los chorros de agua que dispara.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/full/009.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLAS>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

