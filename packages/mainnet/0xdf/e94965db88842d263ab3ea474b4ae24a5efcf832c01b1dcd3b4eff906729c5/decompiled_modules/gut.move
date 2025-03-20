module 0xdfe94965db88842d263ab3ea474b4ae24a5efcf832c01b1dcd3b4eff906729c5::gut {
    struct MigratedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct GUT has drop {
        dummy_field: bool,
    }

    struct Metadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: 0x2::balance::Supply<T0>,
    }

    fun assert_version(arg0: &Metadata<GUT>) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun burn_balance(arg0: &mut Metadata<GUT>, arg1: 0x2::balance::Balance<GUT>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<GUT>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun burn_coin(arg0: &mut Metadata<GUT>, arg1: 0x2::coin::Coin<GUT>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<GUT>(&mut arg0.total_supply, 0x2::coin::into_balance<GUT>(arg1))
    }

    public fun get_total_supply(arg0: &Metadata<GUT>) : &0x2::balance::Supply<GUT> {
        &arg0.total_supply
    }

    public fun get_total_supply_value(arg0: &Metadata<GUT>) : u64 {
        0x2::balance::supply_value<GUT>(&arg0.total_supply)
    }

    fun init(arg0: GUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUT>(arg0, 9, b"GUT", b"Gyrowin evergreenplant stake", b"Gyrowin is a decentralized cross-chain platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyro.win/gyrowin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUT>>(v1);
        let v2 = Metadata<GUT>{
            id           : 0x2::object::new(arg1),
            version      : 1,
            total_supply : 0x2::coin::treasury_into_supply<GUT>(v0),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<GUT>>(0x2::coin::from_balance<GUT>(0x2::balance::increase_supply<GUT>(&mut v2.total_supply, 2500000000000000000), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Metadata<GUT>>(v2);
    }

    entry fun migrate(arg0: &mut Metadata<GUT>, arg1: &0xdfe94965db88842d263ab3ea474b4ae24a5efcf832c01b1dcd3b4eff906729c5::ownership::OwnerCap) {
        assert!(arg0.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg0.version,
            new_version  : 1,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg0.version = 1;
    }

    public(friend) fun mint(arg0: &mut Metadata<GUT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GUT> {
        assert_version(arg0);
        assert!(get_total_supply_value(arg0) <= 5000000000000000000, 2);
        0x2::coin::from_balance<GUT>(0x2::balance::increase_supply<GUT>(&mut arg0.total_supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

