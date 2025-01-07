module 0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert {
    struct RatioUpdatedEvent has copy, drop {
        prevValue: u256,
        newValue: u256,
    }

    struct CERT has drop {
        dummy_field: bool,
    }

    struct Metadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: 0x2::balance::Supply<T0>,
        ratio: u256,
        ratio_threshold: u256,
        ratio_update_timestamp: u64,
    }

    fun assert_version(arg0: &Metadata<CERT>) {
        assert!(arg0.version == 1, 4);
    }

    public(friend) fun burn(arg0: &mut Metadata<CERT>, arg1: 0x2::coin::Coin<CERT>) : u64 {
        assert_version(arg0);
        0x2::balance::decrease_supply<CERT>(&mut arg0.total_supply, 0x2::coin::into_balance<CERT>(arg1))
    }

    public entry fun force_update_ratio(arg0: &mut Metadata<CERT>, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OwnerCap, arg2: u256) {
        assert_version(arg0);
        assert!(arg2 <= 1000000000000000000, 0);
        assert!(arg2 > 0, 1);
        let v0 = RatioUpdatedEvent{
            prevValue : arg0.ratio,
            newValue  : arg2,
        };
        0x2::event::emit<RatioUpdatedEvent>(v0);
        arg0.ratio = arg2;
    }

    public fun from_shares(arg0: &Metadata<CERT>, arg1: u64) : u64 {
        (((arg1 as u256) * 1000000000000000000 / arg0.ratio) as u64)
    }

    public fun get_ratio(arg0: &Metadata<CERT>) : u256 {
        arg0.ratio
    }

    public fun get_total_supply<T0>(arg0: &Metadata<T0>) : &0x2::balance::Supply<T0> {
        &arg0.total_supply
    }

    fun init(arg0: CERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CERT>(arg0, 9, b"ankrSUI", b"Ankr Staked SUI", b"Ankr's SUI staking solution provides the best user experience and highest level of safety, combined with an attractive reward mechanism and instant staking liquidity through a bond-like synthetic token called ankrSUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.ankr.com/staking/tokens/ankrSUI.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CERT>>(v1);
        let v2 = Metadata<CERT>{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            total_supply           : 0x2::coin::treasury_into_supply<CERT>(v0),
            ratio                  : 1000000000000000000,
            ratio_threshold        : 100000000,
            ratio_update_timestamp : 0,
        };
        0x2::transfer::share_object<Metadata<CERT>>(v2);
    }

    entry fun migrate(arg0: &mut Metadata<CERT>, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OwnerCap) {
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
    }

    public(friend) fun mint(arg0: &mut Metadata<CERT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CERT> {
        assert_version(arg0);
        0x2::coin::from_balance<CERT>(0x2::balance::increase_supply<CERT>(&mut arg0.total_supply, arg1), arg2)
    }

    public fun to_shares(arg0: &Metadata<CERT>, arg1: u64) : u64 {
        let v0 = (((arg1 as u256) * arg0.ratio / 1000000000000000000) as u64);
        let v1 = v0;
        if (arg1 > 0 && v0 == 0) {
            v1 = 1;
        };
        v1
    }

    public entry fun update_ratio(arg0: &mut Metadata<CERT>, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OperatorCap, arg2: &0x2::clock::Clock, arg3: u256) {
        assert_version(arg0);
        assert!(arg3 < arg0.ratio, 0);
        assert!(arg3 > 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg0.ratio_update_timestamp > 43200, 3);
        arg0.ratio_update_timestamp = v0;
        assert!(arg3 > arg0.ratio - arg0.ratio * arg0.ratio_threshold / 100000000, 2);
        let v1 = RatioUpdatedEvent{
            prevValue : arg0.ratio,
            newValue  : arg3,
        };
        0x2::event::emit<RatioUpdatedEvent>(v1);
        arg0.ratio = arg3;
    }

    public entry fun update_threshold(arg0: &mut Metadata<CERT>, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OwnerCap, arg2: u256) {
        assert_version(arg0);
        assert!(arg2 > 0, 5);
        assert!(arg2 <= 100000000, 6);
        arg0.ratio_threshold = arg2;
    }

    // decompiled from Move bytecode v6
}

