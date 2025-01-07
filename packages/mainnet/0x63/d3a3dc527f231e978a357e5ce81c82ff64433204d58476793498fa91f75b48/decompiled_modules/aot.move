module 0x63d3a3dc527f231e978a357e5ce81c82ff64433204d58476793498fa91f75b48::aot {
    struct AOT has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<AOT>,
        describe: 0x1::ascii::String,
    }

    public fun mint(arg0: &mut TreasuryCapHolder, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AOT>>(0x2::coin::mint<AOT>(&mut arg0.treasury_cap, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: AOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOT>(arg0, 9, b"windynanzi", b"Windy", b"game coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.icon-icons.com/icons2/1865/PNG/96/dogbaby_119594.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AOT>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            describe     : 0x1::ascii::string(b"ablion"),
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

