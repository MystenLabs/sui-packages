module 0x851e2402c495b1099dcbed8c5743461f23d3153637ce141fa7502eb485327c4d::jwlcetus {
    struct JWLCETUS has drop {
        dummy_field: bool,
    }

    struct JwlCetusMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
    }

    public(friend) fun burn_balance(arg0: &mut JwlCetusMetadata<JWLCETUS>, arg1: 0x2::balance::Balance<JWLCETUS>) : u64 {
        0x2::balance::decrease_supply<JWLCETUS>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun burn_coin(arg0: &mut JwlCetusMetadata<JWLCETUS>, arg1: 0x2::coin::Coin<JWLCETUS>) : u64 {
        0x2::balance::decrease_supply<JWLCETUS>(&mut arg0.total_supply, 0x2::coin::into_balance<JWLCETUS>(arg1))
    }

    public fun get_total_supply(arg0: &JwlCetusMetadata<JWLCETUS>) : &0x2::balance::Supply<JWLCETUS> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &JwlCetusMetadata<JWLCETUS>) : u64 {
        0x2::balance::supply_value<JWLCETUS>(&arg0.total_supply)
    }

    fun init(arg0: JWLCETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWLCETUS>(arg0, 9, b"JWLCETUS", b"JWLCETUS", b"JWLCETUS is a stablecoin pegged to CETUS and minted with CETUS 1:1. Brought to you by JewelSwap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/25114.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JWLCETUS>>(v1);
        let v2 = JwlCetusMetadata<JWLCETUS>{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::coin::treasury_into_supply<JWLCETUS>(v0),
        };
        0x2::transfer::share_object<JwlCetusMetadata<JWLCETUS>>(v2);
    }

    public(friend) fun mint(arg0: &mut JwlCetusMetadata<JWLCETUS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JWLCETUS> {
        0x2::coin::from_balance<JWLCETUS>(0x2::balance::increase_supply<JWLCETUS>(&mut arg0.total_supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

