module 0xb5f0684e421f7a9a72e13080c766e2978e2822a6006c7c8ea8f168834f105fab::coin {
    struct Coin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CoinMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimals: u8,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct TreasuryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
    }

    struct CurrencyCreated<phantom T0> has copy, drop {
        decimals: u8,
    }

    public fun balance<T0>(arg0: &Coin<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun destroy_zero<T0>(arg0: Coin<T0>) {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public entry fun join<T0>(arg0: &mut Coin<T0>, arg1: Coin<T0>) {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
    }

    public fun split<T0>(arg0: &mut Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        let v0 = &mut arg0.balance;
        take<T0>(v0, arg1, arg2)
    }

    public fun value<T0>(arg0: &Coin<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public fun balance_mut<T0>(arg0: &mut Coin<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public entry fun burn<T0>(arg0: &mut TreasuryCap<T0>, arg1: Coin<T0>) : u64 {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::decrease_supply<T0>(&mut arg0.total_supply, v1)
    }

    public fun create_currency<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : (TreasuryCap<T0>, CoinMetadata<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = TreasuryCap<T0>{
            id           : 0x2::object::new(arg6),
            total_supply : 0x2::balance::create_supply<T0>(arg0),
        };
        let v1 = CoinMetadata<T0>{
            id          : 0x2::object::new(arg6),
            decimals    : arg1,
            name        : 0x1::string::utf8(arg3),
            symbol      : 0x1::ascii::string(arg2),
            description : 0x1::string::utf8(arg4),
            icon_url    : arg5,
        };
        (v0, v1)
    }

    public fun divide_into_n<T0>(arg0: &mut Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<Coin<T0>> {
        assert!(arg1 > 0, 1);
        assert!(arg1 <= value<T0>(arg0), 2);
        let v0 = 0x1::vector::empty<Coin<T0>>();
        let v1 = 0;
        let v2 = value<T0>(arg0) / arg1;
        while (v1 < arg1 - 1) {
            0x1::vector::push_back<Coin<T0>>(&mut v0, split<T0>(arg0, v2, arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg1),
            balance : arg0,
        }
    }

    public fun get_decimals<T0>(arg0: &CoinMetadata<T0>) : u8 {
        arg0.decimals
    }

    public fun get_description<T0>(arg0: &CoinMetadata<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun get_icon_url<T0>(arg0: &CoinMetadata<T0>) : 0x1::option::Option<0x2::url::Url> {
        arg0.icon_url
    }

    public fun get_name<T0>(arg0: &CoinMetadata<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_symbol<T0>(arg0: &CoinMetadata<T0>) : 0x1::ascii::String {
        arg0.symbol
    }

    public fun into_balance<T0>(arg0: Coin<T0>) : 0x2::balance::Balance<T0> {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun mint<T0>(arg0: &mut TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::increase_supply<T0>(&mut arg0.total_supply, arg1),
        }
    }

    public entry fun mint_and_transfer<T0>(arg0: &mut TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Coin<T0>>(mint<T0>(arg0, arg1, arg3), arg2);
    }

    public fun mint_balance<T0>(arg0: &mut TreasuryCap<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::increase_supply<T0>(&mut arg0.total_supply, arg1)
    }

    public fun put<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: Coin<T0>) {
        0x2::balance::join<T0>(arg0, into_balance<T0>(arg1));
    }

    public fun supply<T0>(arg0: &mut TreasuryCap<T0>) : &0x2::balance::Supply<T0> {
        &arg0.total_supply
    }

    public fun supply_immut<T0>(arg0: &TreasuryCap<T0>) : &0x2::balance::Supply<T0> {
        &arg0.total_supply
    }

    public fun supply_mut<T0>(arg0: &mut TreasuryCap<T0>) : &mut 0x2::balance::Supply<T0> {
        &mut arg0.total_supply
    }

    public fun take<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::split<T0>(arg0, arg1),
        }
    }

    public fun total_supply<T0>(arg0: &TreasuryCap<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.total_supply)
    }

    public fun treasury_into_supply<T0>(arg0: TreasuryCap<T0>) : 0x2::balance::Supply<T0> {
        let TreasuryCap {
            id           : v0,
            total_supply : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public entry fun update_description<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: 0x1::string::String) {
        arg1.description = arg2;
    }

    public entry fun update_icon_url<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        arg1.icon_url = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(arg2));
    }

    public entry fun update_name<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public entry fun update_symbol<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        arg1.symbol = arg2;
    }

    // decompiled from Move bytecode v6
}

