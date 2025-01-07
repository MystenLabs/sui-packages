module 0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::sca {
    struct SCA has drop {
        dummy_field: bool,
    }

    struct ScaTreasury has key {
        id: 0x2::object::UID,
        hard_cap: u64,
        x_supply: 0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::XSupply<SCA>,
    }

    struct ScaTreasuryCap has store, key {
        id: 0x2::object::UID,
        x_supply_cap: 0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::XSupplyCap<SCA>,
    }

    struct ScaMinted has copy, drop {
        issuer_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ScaIssuerAdded has copy, drop {
        issuer_type: 0x1::type_name::TypeName,
    }

    struct ScaIssuerRemoved has copy, drop {
        issuer_type: 0x1::type_name::TypeName,
    }

    public fun add_issuer<T0: drop>(arg0: &ScaTreasuryCap, arg1: &mut ScaTreasury) {
        0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::add_issuer<SCA, T0>(&arg0.x_supply_cap, &mut arg1.x_supply);
        let v0 = ScaIssuerAdded{issuer_type: 0x1::type_name::get<T0>()};
        0x2::event::emit<ScaIssuerAdded>(v0);
    }

    public fun current_supply(arg0: &ScaTreasury) : u64 {
        0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::supply_value<SCA>(&arg0.x_supply)
    }

    fun init(arg0: SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = init_state(arg0, arg1);
        0x2::transfer::transfer<ScaTreasuryCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ScaTreasury>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCA>>(v2);
    }

    fun init_state(arg0: SCA, arg1: &mut 0x2::tx_context::TxContext) : (ScaTreasury, ScaTreasuryCap, 0x2::coin::CoinMetadata<SCA>) {
        let (v0, v1) = 0x2::coin::create_currency<SCA>(arg0, 9, b"SCA", b"SCA", b"Scallop Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/scallop-io/scallop-decorations-uri/master/img/SCA.png")), arg1);
        let (v2, v3) = 0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::create_x_supply<SCA>(0x2::coin::treasury_into_supply<SCA>(v0), arg1);
        let v4 = ScaTreasury{
            id       : 0x2::object::new(arg1),
            hard_cap : 250000000,
            x_supply : v2,
        };
        let v5 = ScaTreasuryCap{
            id           : 0x2::object::new(arg1),
            x_supply_cap : v3,
        };
        (v4, v5, v1)
    }

    public fun mint<T0: drop>(arg0: T0, arg1: &mut ScaTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SCA> {
        assert!(0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::supply_value<SCA>(&arg1.x_supply) + arg2 <= arg1.hard_cap, 503);
        let v0 = ScaMinted{
            issuer_type : 0x1::type_name::get<T0>(),
            amount      : arg2,
        };
        0x2::event::emit<ScaMinted>(v0);
        0x2::coin::from_balance<SCA>(0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::increase_supply<SCA, T0>(arg0, &mut arg1.x_supply, arg2), arg3)
    }

    public fun mint_with_cap<T0: drop>(arg0: &ScaTreasuryCap, arg1: &mut ScaTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SCA> {
        assert!(0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::supply_value<SCA>(&arg1.x_supply) + arg2 <= arg1.hard_cap, 503);
        let v0 = ScaMinted{
            issuer_type : 0x1::type_name::get<T0>(),
            amount      : arg2,
        };
        0x2::event::emit<ScaMinted>(v0);
        0x2::coin::from_balance<SCA>(0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::increase_supply_with_cap<SCA>(&arg0.x_supply_cap, &mut arg1.x_supply, arg2), arg3)
    }

    public fun remove_issuer<T0: drop>(arg0: &ScaTreasuryCap, arg1: &mut ScaTreasury) {
        0x2ea78ea057262d9fe710dabee64055e308c62c5b01b1dddb52ebc71ed7045b37::x_supply::remove_issuer<SCA, T0>(&arg0.x_supply_cap, &mut arg1.x_supply);
        let v0 = ScaIssuerRemoved{issuer_type: 0x1::type_name::get<T0>()};
        0x2::event::emit<ScaIssuerRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

