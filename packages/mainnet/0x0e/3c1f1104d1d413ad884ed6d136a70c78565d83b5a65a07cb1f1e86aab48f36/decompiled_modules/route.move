module 0xe3c1f1104d1d413ad884ed6d136a70c78565d83b5a65a07cb1f1e86aab48f36::route {
    struct Mint has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        from: address,
    }

    struct ROUTE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROUTE>, arg1: &mut 0x2::coin::Coin<ROUTE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<ROUTE>(arg0, 0x2::coin::split<ROUTE>(arg1, arg2, arg3));
        let v0 = Burn{
            amount : arg2,
            from   : 0x2::object::id_address<0x2::coin::Coin<ROUTE>>(arg1),
        };
        0x2::event::emit<Burn>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROUTE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROUTE>>(0x2::coin::mint<ROUTE>(arg0, arg2, arg3), arg1);
        let v0 = Mint{
            amount    : arg2,
            recipient : arg1,
        };
        0x2::event::emit<Mint>(v0);
    }

    fun init(arg0: ROUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROUTE>(arg0, 9, b"ROUTE", b"ROUTE", b"Official: Route Token From Router Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://shorturl.at/azACY"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROUTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROUTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

