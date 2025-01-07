module 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca {
    struct VE_SCA has drop {
        dummy_field: bool,
    }

    struct VeSca has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<VE_SCA>,
        mint_timestamp: u64,
        issuer_type: 0x1::type_name::TypeName,
    }

    struct VeScaTreasury has key {
        id: 0x2::object::UID,
        x_supply: 0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::XSupply<VE_SCA>,
    }

    struct VeScaCap has store, key {
        id: 0x2::object::UID,
        x_supply_cap: 0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::XSupplyCap<VE_SCA>,
    }

    public fun split(arg0: &mut VeSca, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VeSca {
        VeSca{
            id             : 0x2::object::new(arg2),
            balance        : 0x2::balance::split<VE_SCA>(&mut arg0.balance, arg1),
            mint_timestamp : arg0.mint_timestamp,
            issuer_type    : arg0.issuer_type,
        }
    }

    public fun value(arg0: &VeSca) : u64 {
        0x2::balance::value<VE_SCA>(&arg0.balance)
    }

    public fun add_issuer<T0: drop>(arg0: &VeScaCap, arg1: &mut VeScaTreasury) {
        0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::add_issuer<VE_SCA, T0>(&arg0.x_supply_cap, &mut arg1.x_supply);
    }

    public fun remove_issuer<T0: drop>(arg0: &VeScaCap, arg1: &mut VeScaTreasury) {
        0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::remove_issuer<VE_SCA, T0>(&arg0.x_supply_cap, &mut arg1.x_supply);
    }

    public fun burn<T0: drop>(arg0: T0, arg1: &mut VeScaTreasury, arg2: VeSca) : u64 {
        let VeSca {
            id             : v0,
            balance        : v1,
            mint_timestamp : _,
            issuer_type    : v3,
        } = arg2;
        0x2::object::delete(v0);
        assert!(v3 == 0x1::type_name::get<T0>(), 403);
        0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::decrease_supply<VE_SCA, T0>(arg0, &mut arg1.x_supply, v1)
    }

    fun init(arg0: VE_SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::create_x_supply<VE_SCA>(0x2::balance::create_supply<VE_SCA>(arg0), arg1);
        let v2 = VeScaTreasury{
            id       : 0x2::object::new(arg1),
            x_supply : v0,
        };
        let v3 = VeScaCap{
            id           : 0x2::object::new(arg1),
            x_supply_cap : v1,
        };
        0x2::transfer::transfer<VeScaCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<VeScaTreasury>(v2);
    }

    public fun issuer_type(arg0: &VeSca) : 0x1::type_name::TypeName {
        arg0.issuer_type
    }

    public fun mint<T0: drop>(arg0: T0, arg1: &mut VeScaTreasury, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : VeSca {
        VeSca{
            id             : 0x2::object::new(arg4),
            balance        : 0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply::increase_supply<VE_SCA, T0>(arg0, &mut arg1.x_supply, arg2),
            mint_timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
            issuer_type    : 0x1::type_name::get<T0>(),
        }
    }

    public fun mint_timestamp(arg0: &VeSca) : u64 {
        arg0.mint_timestamp
    }

    // decompiled from Move bytecode v6
}

