module 0x72743370edc8737798786e4001336664ca079727e769830e5efdeb54d8e512b3::uhpzbouz {
    struct UHPZBOUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHPZBOUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UHPZBOUZ>(arg0, 6, b"uhpzbouz", b"uhpzbouz", b"uun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UHPZBOUZ>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHPZBOUZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UHPZBOUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

