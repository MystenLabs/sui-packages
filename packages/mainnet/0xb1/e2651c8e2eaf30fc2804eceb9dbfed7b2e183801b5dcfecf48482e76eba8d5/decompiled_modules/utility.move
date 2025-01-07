module 0xb1e2651c8e2eaf30fc2804eceb9dbfed7b2e183801b5dcfecf48482e76eba8d5::utility {
    struct MigratedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct UTILITY has drop {
        dummy_field: bool,
    }

    struct Metadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: 0x2::balance::Supply<T0>,
    }

    fun assert_version(arg0: &Metadata<UTILITY>) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun burn_balance(arg0: &mut Metadata<UTILITY>, arg1: 0x2::balance::Balance<UTILITY>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<UTILITY>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun burn_coin(arg0: &mut Metadata<UTILITY>, arg1: 0x2::coin::Coin<UTILITY>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<UTILITY>(&mut arg0.total_supply, 0x2::coin::into_balance<UTILITY>(arg1))
    }

    public fun get_total_supply(arg0: &Metadata<UTILITY>) : &0x2::balance::Supply<UTILITY> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &Metadata<UTILITY>) : u64 {
        0x2::balance::supply_value<UTILITY>(&arg0.total_supply)
    }

    fun init(arg0: UTILITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTILITY>(arg0, 9, b"GUT", b"Gyrowin evergreenplant stake", b"Gyrowin is a decentralized cross-chain platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyro.win/gyrowin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UTILITY>>(v1);
        let v2 = Metadata<UTILITY>{
            id           : 0x2::object::new(arg1),
            version      : 1,
            total_supply : 0x2::coin::treasury_into_supply<UTILITY>(v0),
        };
        0x2::transfer::share_object<Metadata<UTILITY>>(v2);
    }

    entry fun migrate(arg0: &mut Metadata<UTILITY>, arg1: &0xb1e2651c8e2eaf30fc2804eceb9dbfed7b2e183801b5dcfecf48482e76eba8d5::ownership::OwnerCap) {
        assert!(arg0.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg0.version,
            new_version  : 1,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg0.version = 1;
    }

    public(friend) fun mint(arg0: &mut Metadata<UTILITY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UTILITY> {
        assert_version(arg0);
        0x2::coin::from_balance<UTILITY>(0x2::balance::increase_supply<UTILITY>(&mut arg0.total_supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

