module 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::magma_token {
    struct MAGMA_TOKEN has drop {
        dummy_field: bool,
    }

    struct MinterCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun burn<T0>(arg0: &mut MinterCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(&mut arg0.cap, arg1);
    }

    public fun mint<T0>(arg0: &mut MinterCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 != @0x0, 0);
        0x2::coin::mint<T0>(&mut arg0.cap, arg1, arg3)
    }

    public fun total_supply<T0>(arg0: &MinterCap<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.cap)
    }

    fun init(arg0: MAGMA_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGMA_TOKEN>(arg0, 6, b"MGM", b"Magma", b"Magma Protocol Governance Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = MinterCap<MAGMA_TOKEN>{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::transfer<MinterCap<MAGMA_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGMA_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

