module 0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca {
    struct SCA has drop {
        dummy_field: bool,
    }

    struct ScaTreasury has key {
        id: 0x2::object::UID,
        hard_cap: u64,
        x_supply: 0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::XSupply<SCA>,
    }

    struct ScaTreasuryCap has store, key {
        id: 0x2::object::UID,
        x_supply_cap: 0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::XSupplyCap<SCA>,
    }

    public fun add_issuer<T0: drop>(arg0: &ScaTreasuryCap, arg1: &mut ScaTreasury) {
        0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::add_issuer<SCA, T0>(&arg0.x_supply_cap, &mut arg1.x_supply);
    }

    public fun remove_issuer<T0: drop>(arg0: &ScaTreasuryCap, arg1: &mut ScaTreasury) {
        0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::remove_issuer<SCA, T0>(&arg0.x_supply_cap, &mut arg1.x_supply);
    }

    public fun current_supply(arg0: &ScaTreasury) : u64 {
        0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::supply_value<SCA>(&arg0.x_supply)
    }

    fun init(arg0: SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<SCA>(arg0, v0, b"SCA", b"SCA", b"Scallop Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/scallop-io/scallop-decorations-uri/master/img/SCA.png")), arg1);
        let (v3, v4) = 0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::create_x_supply<SCA>(0x2::coin::treasury_into_supply<SCA>(v1), arg1);
        let v5 = ScaTreasury{
            id       : 0x2::object::new(arg1),
            hard_cap : 0x2::math::pow(10, v0 + 7) * 25,
            x_supply : v3,
        };
        let v6 = ScaTreasuryCap{
            id           : 0x2::object::new(arg1),
            x_supply_cap : v4,
        };
        0x2::transfer::transfer<ScaTreasuryCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ScaTreasury>(v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCA>>(v2);
    }

    public fun mint<T0: drop>(arg0: T0, arg1: &mut ScaTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SCA> {
        assert!(0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::supply_value<SCA>(&arg1.x_supply) + arg2 <= arg1.hard_cap, 503);
        0x2::coin::from_balance<SCA>(0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::increase_supply<SCA, T0>(arg0, &mut arg1.x_supply, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

