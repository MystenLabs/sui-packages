module 0x4cab4e96720e282d5e73300bbb58534c0610da30c62cd2dc8bea1f1c1bd0a00::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 8, b"BSUI", b"Buttersui", b"=)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/012.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BSUI>(&mut v2, 30000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

