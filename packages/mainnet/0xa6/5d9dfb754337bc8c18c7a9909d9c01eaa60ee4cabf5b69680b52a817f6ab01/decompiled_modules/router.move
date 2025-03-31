module 0x8a28c49180f397299aba3c99c037e22808c3bb8b97c65909d1d5baf28c8905e9::router {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
    }

    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referal_address: address,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    struct UpgradeEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct ChangeAdminEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 11);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{
            old_admin : 0x2::tx_context::sender(arg2),
            new_admin : arg1,
        };
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    public fun check_dexrouter_version(arg0: &Version) {
        assert!(arg0.version == 4, 9);
    }

    public fun deepbook_swap_base_to_quote_with_return<T0, T1>(arg0: &mut Version, arg1: &mut 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_dexrouter_version(arg0);
        abort 0
    }

    public fun deepbook_swap_quote_to_base_with_return<T0, T1>(arg0: &mut Version, arg1: &mut 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_dexrouter_version(arg0);
        abort 0
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: &mut Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_dexrouter_version(arg0);
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Version{
            id      : 0x2::object::new(arg0),
            version : 4,
            admin   : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::transfer::share_object<Version>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &mut Version, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 8);
        let v0 = arg0.version;
        assert!(v0 < 4, 10);
        arg0.version = 4;
        let v1 = UpgradeEvent{
            old_version : v0,
            new_version : 4,
        };
        0x2::event::emit<UpgradeEvent>(v1);
    }

    public fun scallop_swap_exact_swap_a2b_with_return<T0, T1>(arg0: &mut Version, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_dexrouter_version(arg0);
        abort 0
    }

    public fun scallop_swap_exact_swap_b2a_with_return<T0, T1>(arg0: &mut Version, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_dexrouter_version(arg0);
        abort 0
    }

    public fun split_with_percentage<T0>(arg0: &mut Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        check_dexrouter_version(arg0);
        abort 0
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &mut Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_dexrouter_version(arg0);
        abort 0
    }

    // decompiled from Move bytecode v6
}

