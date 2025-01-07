module 0x6bccd832ba83d49e4368a56de635df7d57bf0bb1ccd2ade7a4fc3a22ffc04e6c::povosui {
    struct POVOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POVOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POVOSUI>(arg0, 9, b"POVOSUI", b"Povo Coin", b"Povo sui now coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.imagenspng.com.br/wp-content/uploads/2021/11/bolofofos-pow-png-01.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POVOSUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POVOSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POVOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

