module 0xeefbc16f4a2be40bc113269b56913fbbfafc8baf73dd029d862646930c750524::jwlsui {
    struct JWLSUI has drop {
        dummy_field: bool,
    }

    struct JwlSuiMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
    }

    public(friend) fun burn_balance(arg0: &mut JwlSuiMetadata<JWLSUI>, arg1: 0x2::balance::Balance<JWLSUI>) : u64 {
        0x2::balance::decrease_supply<JWLSUI>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun burn_coin(arg0: &mut JwlSuiMetadata<JWLSUI>, arg1: 0x2::coin::Coin<JWLSUI>) : u64 {
        0x2::balance::decrease_supply<JWLSUI>(&mut arg0.total_supply, 0x2::coin::into_balance<JWLSUI>(arg1))
    }

    public fun get_total_supply(arg0: &JwlSuiMetadata<JWLSUI>) : &0x2::balance::Supply<JWLSUI> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &JwlSuiMetadata<JWLSUI>) : u64 {
        0x2::balance::supply_value<JWLSUI>(&arg0.total_supply)
    }

    fun init(arg0: JWLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWLSUI>(arg0, 9, b"JWLSUI", b"JWLSUI", b"JWLSUI is a stablecoin pegged to SUI and minted with SUI 1:1. Brought to you by JewelSwap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://github.com/JewelSwapXFinance/jewelswap-token-logos/blob/main/sui/jwlsui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JWLSUI>>(v1);
        let v2 = JwlSuiMetadata<JWLSUI>{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::coin::treasury_into_supply<JWLSUI>(v0),
        };
        0x2::transfer::share_object<JwlSuiMetadata<JWLSUI>>(v2);
    }

    public(friend) fun mint(arg0: &mut JwlSuiMetadata<JWLSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JWLSUI> {
        0x2::coin::from_balance<JWLSUI>(0x2::balance::increase_supply<JWLSUI>(&mut arg0.total_supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

