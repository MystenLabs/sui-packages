module 0x2fcbd4572579490ffe11ed7786f8f9b3de6838b8fee93ecc12ad62b72ba21e44::whsui {
    struct MigratedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct WHSUI has drop {
        dummy_field: bool,
    }

    struct Metadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: 0x2::balance::Supply<T0>,
    }

    fun assert_version(arg0: &Metadata<WHSUI>) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun burn_balance(arg0: &mut Metadata<WHSUI>, arg1: 0x2::balance::Balance<WHSUI>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<WHSUI>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun burn_coin(arg0: &mut Metadata<WHSUI>, arg1: 0x2::coin::Coin<WHSUI>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<WHSUI>(&mut arg0.total_supply, 0x2::coin::into_balance<WHSUI>(arg1))
    }

    public fun get_total_supply(arg0: &Metadata<WHSUI>) : &0x2::balance::Supply<WHSUI> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &Metadata<WHSUI>) : u64 {
        0x2::balance::supply_value<WHSUI>(&arg0.total_supply)
    }

    fun init(arg0: WHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHSUI>(arg0, 9, b"whSUI", b"WheatChain Staked SUI", b"whSUI is a reward-bearing token representing staked SUI assets plus accrued staking rewards. Unlike standard tokens, whSUI does not increase in number but grows in value over time. As staking rewards accumulate, 1 whSUI becomes worth increasingly more than 1 SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/wheat-eco/Aptos-Tokens/refs/heads/main/logos/SWHIT.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHSUI>>(v1);
        let v2 = Metadata<WHSUI>{
            id           : 0x2::object::new(arg1),
            version      : 1,
            total_supply : 0x2::coin::treasury_into_supply<WHSUI>(v0),
        };
        0x2::transfer::share_object<Metadata<WHSUI>>(v2);
    }

    entry fun migrate(arg0: &mut Metadata<WHSUI>, arg1: &0x2fcbd4572579490ffe11ed7786f8f9b3de6838b8fee93ecc12ad62b72ba21e44::ownership::OwnerCap) {
        assert!(arg0.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg0.version,
            new_version  : 1,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg0.version = 1;
    }

    public(friend) fun mint(arg0: &mut Metadata<WHSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WHSUI> {
        assert_version(arg0);
        0x2::coin::from_balance<WHSUI>(0x2::balance::increase_supply<WHSUI>(&mut arg0.total_supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

