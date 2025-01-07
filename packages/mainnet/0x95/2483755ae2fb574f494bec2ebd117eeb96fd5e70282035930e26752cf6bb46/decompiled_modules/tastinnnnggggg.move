module 0x952483755ae2fb574f494bec2ebd117eeb96fd5e70282035930e26752cf6bb46::tastinnnnggggg {
    struct TASTINNNNGGGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASTINNNNGGGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TASTINNNNGGGGG>(arg0, 6, b"Tastinnnnggggg", b"testilling", b"tastiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_06_14_14_48_56_559a6a8c8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASTINNNNGGGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TASTINNNNGGGGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

