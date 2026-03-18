module 0x6cb19226cf5d0c8ad11e9b64f55f125ebacd88ad2476d7813a01bfc9414a67a0::jwlxmn {
    struct JWLXMN has drop {
        dummy_field: bool,
    }

    struct JwlXmnMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
    }

    public(friend) fun burn_balance(arg0: &mut JwlXmnMetadata<JWLXMN>, arg1: 0x2::balance::Balance<JWLXMN>) : u64 {
        0x2::balance::decrease_supply<JWLXMN>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun burn_coin(arg0: &mut JwlXmnMetadata<JWLXMN>, arg1: 0x2::coin::Coin<JWLXMN>) : u64 {
        0x2::balance::decrease_supply<JWLXMN>(&mut arg0.total_supply, 0x2::coin::into_balance<JWLXMN>(arg1))
    }

    public fun get_total_supply(arg0: &JwlXmnMetadata<JWLXMN>) : &0x2::balance::Supply<JWLXMN> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &JwlXmnMetadata<JWLXMN>) : u64 {
        0x2::balance::supply_value<JWLXMN>(&arg0.total_supply)
    }

    fun init(arg0: JWLXMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWLXMN>(arg0, 9, b"JWLXMN", b"JWLXMN", b"JWLXMN is a stablecoin pegged to XMN and minted with XMN 1:1. Brought to you by JewelSwap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/20947.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JWLXMN>>(v1);
        let v2 = JwlXmnMetadata<JWLXMN>{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::coin::treasury_into_supply<JWLXMN>(v0),
        };
        0x2::transfer::share_object<JwlXmnMetadata<JWLXMN>>(v2);
    }

    public(friend) fun mint(arg0: &mut JwlXmnMetadata<JWLXMN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JWLXMN> {
        0x2::coin::from_balance<JWLXMN>(0x2::balance::increase_supply<JWLXMN>(&mut arg0.total_supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

