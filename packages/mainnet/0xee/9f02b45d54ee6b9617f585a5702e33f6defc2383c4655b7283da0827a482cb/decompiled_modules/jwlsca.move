module 0xee9f02b45d54ee6b9617f585a5702e33f6defc2383c4655b7283da0827a482cb::jwlsca {
    struct JWLSCA has drop {
        dummy_field: bool,
    }

    struct JwlScaMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
    }

    public(friend) fun burn_balance(arg0: &mut JwlScaMetadata<JWLSCA>, arg1: 0x2::balance::Balance<JWLSCA>) : u64 {
        0x2::balance::decrease_supply<JWLSCA>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun burn_coin(arg0: &mut JwlScaMetadata<JWLSCA>, arg1: 0x2::coin::Coin<JWLSCA>) : u64 {
        0x2::balance::decrease_supply<JWLSCA>(&mut arg0.total_supply, 0x2::coin::into_balance<JWLSCA>(arg1))
    }

    public fun get_total_supply(arg0: &JwlScaMetadata<JWLSCA>) : &0x2::balance::Supply<JWLSCA> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &JwlScaMetadata<JWLSCA>) : u64 {
        0x2::balance::supply_value<JWLSCA>(&arg0.total_supply)
    }

    fun init(arg0: JWLSCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWLSCA>(arg0, 9, b"JWLSCA", b"JWLSCA", b"JWLSCA is a stablecoin pegged to SCA and minted with SCA 1:1. Brought to you by JewelSwap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/29679.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JWLSCA>>(v1);
        let v2 = JwlScaMetadata<JWLSCA>{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::coin::treasury_into_supply<JWLSCA>(v0),
        };
        0x2::transfer::share_object<JwlScaMetadata<JWLSCA>>(v2);
    }

    public(friend) fun mint(arg0: &mut JwlScaMetadata<JWLSCA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JWLSCA> {
        0x2::coin::from_balance<JWLSCA>(0x2::balance::increase_supply<JWLSCA>(&mut arg0.total_supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

