module 0xcb652dfcf022f7680374314673e27603672c52606d92604eba6fcda066b69f6a::rats {
    struct RATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATS>(arg0, 9, b"RATS", b"Sui Rats", b"The Sui Most Loved Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1831519367873404928/-GC_aTvP_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RATS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

