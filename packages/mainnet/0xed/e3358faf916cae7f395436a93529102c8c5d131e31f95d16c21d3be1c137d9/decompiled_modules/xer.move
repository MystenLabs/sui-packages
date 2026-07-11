module 0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer {
    struct XER has drop {
        dummy_field: bool,
    }

    struct XerTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<XER>,
    }

    struct SupplyBurned has copy, drop {
        amount: u64,
        remaining: u64,
    }

    public fun burn(arg0: &mut XerTreasury, arg1: 0x2::coin::Coin<XER>) : u64 {
        let v0 = 0x2::coin::value<XER>(&arg1);
        0x2::coin::burn<XER>(&mut arg0.cap, arg1);
        let v1 = SupplyBurned{
            amount    : v0,
            remaining : 0x2::coin::total_supply<XER>(&arg0.cap),
        };
        0x2::event::emit<SupplyBurned>(v1);
        v0
    }

    public fun total_supply(arg0: &XerTreasury) : u64 {
        0x2::coin::total_supply<XER>(&arg0.cap)
    }

    fun init(arg0: XER, arg1: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0, arg1);
    }

    fun init_internal(arg0: XER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XER>(arg0, 9, b"XER", b"Xerion", b"Xerion utility & governance token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.xerion.finance/coin.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<XER>>(0x2::coin::mint<XER>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XER>>(v1);
        let v3 = XerTreasury{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<XerTreasury>(v3);
    }

    public fun max_supply() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v7
}

