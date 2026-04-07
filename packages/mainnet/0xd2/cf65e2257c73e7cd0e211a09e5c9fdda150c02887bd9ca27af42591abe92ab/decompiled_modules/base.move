module 0xd2cf65e2257c73e7cd0e211a09e5c9fdda150c02887bd9ca27af42591abe92ab::base {
    struct BASE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<BASE>, arg1: 0x2::coin::Coin<BASE>) {
        0x2::coin::burn<BASE>(arg0, arg1);
    }

    public fun grant(arg0: &mut 0x2::coin::TreasuryCap<BASE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASE> {
        0x2::coin::mint<BASE>(arg0, arg1, arg2)
    }

    public entry fun grant_to(arg0: &mut 0x2::coin::TreasuryCap<BASE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASE>>(0x2::coin::mint<BASE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASE>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-qSX-pvoR06.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BASE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASE>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

