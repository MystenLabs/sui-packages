module 0x2a3e91bea9fc6d2af34aa9d510a375d68020c6b62377bb00646e0010435814cb::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHARK>, arg1: 0x2::coin::Coin<SHARK>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHARK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHARK>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"SHARK", b"SHARK", x"24534841524b206e696d626c792063726f7373657320497473207761746572732c206c75726564206279207468652061726f6d61746963207363656e74206f662074686520626c6f6f6479206d61726b657420f09fa9b820497420717569636b6c79206561747320616c6c207265642064697073206163726f73732068696d2120f09f9fa2202020202068747470733a2f2f782e636f6d2f536861766b54726f6e202068747470733a2f2f742e6d652f736861766b74726f6e202068747470733a2f2f736861766b2e78797a2f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-shocked-dinosaur-182.mypinata.cloud/ipfs/QmTGjRUpz4vW5NYR6aaiGsaqWsE14LwowHeKV1xNv6F7Fg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SHARK>, arg1: 0x2::coin::Coin<SHARK>) : u64 {
        0x2::coin::burn<SHARK>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SHARK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SHARK> {
        0x2::coin::mint<SHARK>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

