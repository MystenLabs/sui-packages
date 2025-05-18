module 0x49a1a22d6ccabd38e7acebef040d45b69aa2901dbb5262e63a1fd22322cb57::kemon {
    struct KEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEMON>(arg0, 6, b"KEMON", b"BLUE POKEMON", b"The first Blue pokemon on sui network!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreife4uwct36rlmbfudavlm334v3ua63qglurmip4rov5mqdckxqbs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

