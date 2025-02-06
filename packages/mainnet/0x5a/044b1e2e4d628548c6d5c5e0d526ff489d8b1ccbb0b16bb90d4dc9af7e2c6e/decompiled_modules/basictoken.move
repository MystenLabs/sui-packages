module 0x5a044b1e2e4d628548c6d5c5e0d526ff489d8b1ccbb0b16bb90d4dc9af7e2c6e::basictoken {
    struct BASICTOKEN has drop {
        dummy_field: bool,
    }

    struct BASICTOKENMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
    }

    public fun burn_balance(arg0: &mut BASICTOKENMetadata<BASICTOKEN>, arg1: 0x2::balance::Balance<BASICTOKEN>) : u64 {
        0x2::balance::decrease_supply<BASICTOKEN>(&mut arg0.total_supply, arg1)
    }

    public fun burn_coin(arg0: &mut BASICTOKENMetadata<BASICTOKEN>, arg1: 0x2::coin::Coin<BASICTOKEN>) : u64 {
        0x2::balance::decrease_supply<BASICTOKEN>(&mut arg0.total_supply, 0x2::coin::into_balance<BASICTOKEN>(arg1))
    }

    public fun get_total_supply(arg0: &BASICTOKENMetadata<BASICTOKEN>) : &0x2::balance::Supply<BASICTOKEN> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &BASICTOKENMetadata<BASICTOKEN>) : u64 {
        0x2::balance::supply_value<BASICTOKEN>(&arg0.total_supply)
    }

    fun init(arg0: BASICTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASICTOKEN>(arg0, 9, b"BTKN6", b"BASICTOKEN6", b"Description of the BASICTOKEN6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/2tmTR1t.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASICTOKEN>>(v1);
        let v2 = BASICTOKENMetadata<BASICTOKEN>{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::coin::treasury_into_supply<BASICTOKEN>(v0),
        };
        0x2::transfer::share_object<BASICTOKENMetadata<BASICTOKEN>>(v2);
    }

    public entry fun mint(arg0: &mut BASICTOKENMetadata<BASICTOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASICTOKEN>>(0x2::coin::from_balance<BASICTOKEN>(0x2::balance::increase_supply<BASICTOKEN>(&mut arg0.total_supply, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_and_transfer(arg0: &mut BASICTOKENMetadata<BASICTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASICTOKEN>>(0x2::coin::from_balance<BASICTOKEN>(0x2::balance::increase_supply<BASICTOKEN>(&mut arg0.total_supply, arg1), arg3), arg2);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<BASICTOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASICTOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

