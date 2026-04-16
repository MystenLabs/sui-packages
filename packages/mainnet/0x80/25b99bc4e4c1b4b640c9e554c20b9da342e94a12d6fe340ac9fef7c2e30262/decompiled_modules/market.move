module 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market {
    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::version::Version,
        fee_recipient: address,
        open_fee_rate: u64,
        close_fee_rate: u64,
        permissions: 0x2::vec_set::VecSet<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::Permission>,
    }

    struct CreateMarketEvent has copy, drop {
        market_id: 0x2::object::ID,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
        open_fee_rate: u64,
        close_fee_rate: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        open_fee_rate: u64,
        close_fee_rate: u64,
    }

    struct UpdateMarketPermissionEvent has copy, drop {
        market_id: 0x2::object::ID,
        permission: 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::Permission,
        is_pause: bool,
        sender: address,
    }

    public(friend) fun check_permission<T0, T1>(arg0: &Market<T0, T1>, arg1: 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::Permission) {
        assert!(0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::check_permission(&arg0.permissions, arg1), 13906834913078083590);
    }

    public fun permissions<T0, T1>(arg0: &Market<T0, T1>) : &0x2::vec_set::VecSet<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::Permission> {
        &arg0.permissions
    }

    public fun check_version<T0, T1>(arg0: &Market<T0, T1>) {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::version::assert_version(&arg0.version, 2);
    }

    public fun close_fee_rate<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.close_fee_rate
    }

    public fun create_market<T0, T1>(arg0: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::admin_cap::AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100000, 13906834483581222916);
        assert!(arg3 <= 100000, 13906834487876190212);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v1 != v2, 10001);
        let v3 = Market<T0, T1>{
            id             : v0,
            version        : 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::version::new(2),
            fee_recipient  : arg1,
            open_fee_rate  : arg2,
            close_fee_rate : arg3,
            permissions    : 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::all(),
        };
        let v4 = CreateMarketEvent{
            market_id      : 0x2::object::uid_to_inner(&v0),
            base_token     : v1,
            quote_token    : v2,
            open_fee_rate  : arg2,
            close_fee_rate : arg3,
        };
        0x2::event::emit<CreateMarketEvent>(v4);
        0x2::transfer::share_object<Market<T0, T1>>(v3);
    }

    public fun fee_recipient<T0, T1>(arg0: &Market<T0, T1>) : address {
        arg0.fee_recipient
    }

    public fun market_id<T0, T1>(arg0: &Market<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun open_fee_rate<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.open_fee_rate
    }

    public fun set_fee_rate<T0, T1>(arg0: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::admin_cap::AdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: u64) {
        check_version<T0, T1>(arg1);
        assert!(arg2 <= 100000, 13906834762754097156);
        assert!(arg3 <= 100000, 13906834767049064452);
        if (arg1.open_fee_rate == arg2 && arg1.close_fee_rate == arg3) {
            return
        };
        arg1.open_fee_rate = arg2;
        arg1.close_fee_rate = arg3;
        let v0 = MarketUpdatedEvent{
            market_id      : 0x2::object::id<Market<T0, T1>>(arg1),
            open_fee_rate  : arg2,
            close_fee_rate : arg3,
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    public fun set_fee_recipient<T0, T1>(arg0: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::admin_cap::AdminCap, arg1: &mut Market<T0, T1>, arg2: address) {
        check_version<T0, T1>(arg1);
        arg1.fee_recipient = arg2;
    }

    public fun update_market_permission<T0, T1>(arg0: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::admin_cap::AdminCap, arg1: &mut Market<T0, T1>, arg2: 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::Permission, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg1);
        if (!arg3 == 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::check_permission(&arg1.permissions, arg2)) {
            return
        };
        if (!arg3) {
            0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::set_permission(&mut arg1.permissions, arg2);
        } else {
            0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::unset_permission(&mut arg1.permissions, arg2);
        };
        let v0 = UpdateMarketPermissionEvent{
            market_id  : 0x2::object::id<Market<T0, T1>>(arg1),
            permission : arg2,
            is_pause   : arg3,
            sender     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpdateMarketPermissionEvent>(v0);
    }

    public fun upgrade_version<T0, T1>(arg0: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::admin_cap::AdminCap, arg1: &mut Market<T0, T1>) {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::version::assert_version_and_upgrade(&mut arg1.version, 2);
    }

    // decompiled from Move bytecode v7
}

