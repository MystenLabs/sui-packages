module 0x6c8227cd144256d139d0d2975908ab091afc6fc07d1e0aae55329ae946cc5e9f::pokemon {
    struct POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMON>(arg0, 6, b"POKEMON", b"POKEMON META", b"POKEMON META.EXE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihazpew54htopvz6kca7zkz43wiraebq2ngwh5sbr6r2pvvmclt2e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

