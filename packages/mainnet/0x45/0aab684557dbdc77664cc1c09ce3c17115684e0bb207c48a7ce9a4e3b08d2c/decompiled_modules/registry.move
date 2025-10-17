module 0x450aab684557dbdc77664cc1c09ce3c17115684e0bb207c48a7ce9a4e3b08d2c::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SetPriceCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoinDecimalsRegistry has key {
        id: 0x2::object::UID,
        coin_decimals_table: 0x2::table::Table<0x1::type_name::TypeName, u8>,
    }

    struct SetPriceCapRegistry has key {
        id: 0x2::object::UID,
        revoke_set_price_cap_table: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct SetPriceCapIssuedEvent has copy, drop, store {
        cap_id: 0x2::object::ID,
    }

    struct SetPriceCapRevokedEvent has copy, drop, store {
        cap_id: 0x2::object::ID,
    }

    struct CoinDecimalsUpdatedEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
    }

    public fun get_coin_decimals(arg0: &CoinDecimalsRegistry, arg1: 0x1::type_name::TypeName) : u8 {
        *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.coin_decimals_table, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinDecimalsRegistry{
            id                  : 0x2::object::new(arg0),
            coin_decimals_table : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
        };
        let v1 = SetPriceCapRegistry{
            id                         : 0x2::object::new(arg0),
            revoke_set_price_cap_table : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<CoinDecimalsRegistry>(v0);
        0x2::transfer::share_object<SetPriceCapRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun init_cap_registry(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SetPriceCapRegistry{
            id                         : 0x2::object::new(arg1),
            revoke_set_price_cap_table : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        0x2::transfer::share_object<SetPriceCapRegistry>(v0);
    }

    public fun is_revoked(arg0: &SetPriceCapRegistry, arg1: &SetPriceCap) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoke_set_price_cap_table, 0x2::object::id<SetPriceCap>(arg1))
    }

    public fun issue_set_price_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : SetPriceCap {
        let v0 = SetPriceCap{id: 0x2::object::new(arg1)};
        let v1 = SetPriceCapIssuedEvent{cap_id: 0x2::object::id<SetPriceCap>(&v0)};
        0x2::event::emit<SetPriceCapIssuedEvent>(v1);
        v0
    }

    public fun revoke_set_price_cap(arg0: &AdminCap, arg1: &SetPriceCap, arg2: &mut SetPriceCapRegistry) {
        let v0 = 0x2::object::id<SetPriceCap>(arg1);
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg2.revoke_set_price_cap_table, v0)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg2.revoke_set_price_cap_table, v0, true);
            let v1 = SetPriceCapRevokedEvent{cap_id: v0};
            0x2::event::emit<SetPriceCapRevokedEvent>(v1);
        };
    }

    public fun set_coin_decimals<T0>(arg0: &AdminCap, arg1: &mut CoinDecimalsRegistry, arg2: u8) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u8>(&arg1.coin_decimals_table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u8>(&mut arg1.coin_decimals_table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg1.coin_decimals_table, v0, arg2);
        let v1 = CoinDecimalsUpdatedEvent{
            coin_type : v0,
            decimals  : arg2,
        };
        0x2::event::emit<CoinDecimalsUpdatedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

