module 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::cert {
    struct MigratedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct CERT has drop {
        dummy_field: bool,
    }

    struct Metadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: 0x2::balance::Supply<T0>,
    }

    fun assert_version(arg0: &Metadata<CERT>) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun burn_balance(arg0: &mut Metadata<CERT>, arg1: 0x2::balance::Balance<CERT>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<CERT>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun burn_coin(arg0: &mut Metadata<CERT>, arg1: 0x2::coin::Coin<CERT>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<CERT>(&mut arg0.total_supply, 0x2::coin::into_balance<CERT>(arg1))
    }

    public fun get_total_supply(arg0: &Metadata<CERT>) : &0x2::balance::Supply<CERT> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &Metadata<CERT>) : u64 {
        0x2::balance::supply_value<CERT>(&arg0.total_supply)
    }

    fun init(arg0: CERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CERT>(arg0, 9, b"vSUI", b"Volo Staked SUI", b"Volo's SUI staking solution provides the best user experience and highest level of decentralization, security, combined with an attractive reward mechanism and instant staking liquidity through a bond-like synthetic token called voloSUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://volo.fi/vSUI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CERT>>(v1);
        let v2 = Metadata<CERT>{
            id           : 0x2::object::new(arg1),
            version      : 1,
            total_supply : 0x2::coin::treasury_into_supply<CERT>(v0),
        };
        0x2::transfer::share_object<Metadata<CERT>>(v2);
    }

    entry fun migrate(arg0: &mut Metadata<CERT>, arg1: &0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::ownership::OwnerCap) {
        assert!(arg0.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg0.version,
            new_version  : 1,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg0.version = 1;
    }

    public(friend) fun mint(arg0: &mut Metadata<CERT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CERT> {
        assert_version(arg0);
        0x2::coin::from_balance<CERT>(0x2::balance::increase_supply<CERT>(&mut arg0.total_supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

