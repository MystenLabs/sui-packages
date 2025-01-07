module 0x53e9c0d8cc318b41a27258d0c9f4c9f44e9cf0cd80dcd3296d9523814371f3a6::dough {
    struct DOUGH has drop {
        dummy_field: bool,
    }

    struct TreasuryWrapper<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun burn<T0>(arg0: &mut TreasuryWrapper<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
    }

    public fun mint<T0>(arg0: &mut TreasuryWrapper<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg2)
    }

    fun init(arg0: DOUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUGH>(arg0, 9, b"Dough", b"Dough", b"Fake dough to play DoubleUp games for free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/pZZxpoB.png")), arg1);
        let v2 = TreasuryWrapper<DOUGH>{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryWrapper<DOUGH>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOUGH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

