module 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger {
    struct LEDGER has drop {
        dummy_field: bool,
    }

    struct StateKey has copy, drop, store {
        pos0: u64,
    }

    struct InitCap has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct Ledger has key {
        id: 0x2::object::UID,
        package_id: address,
        version: u64,
    }

    public fun add_allowed_chain(arg0: &mut Ledger, arg1: &0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::admin::AdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::add_allowed_chain(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), arg2);
    }

    public fun add_ika_balance<T0: drop>(arg0: &mut Ledger, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::add_ika_balance(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
    }

    public fun add_presign<T0: drop>(arg0: &mut Ledger, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : address {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::add_presign(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), arg1, 0x1::type_name::with_defining_ids<T0>(), arg2, arg3)
    }

    public fun add_sui_balance<T0: drop>(arg0: &mut Ledger, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::add_sui_balance(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun add_wallet<T0: drop>(arg0: &mut Ledger, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: T0, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u32, arg8: u32, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) : (u64, address) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::add_wallet(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), arg1, 0x1::type_name::with_defining_ids<T0>(), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun decrement_balance<T0: drop>(arg0: &mut Ledger, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: T0, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: u8, arg8: vector<u8>, arg9: u256, arg10: &mut 0x2::tx_context::TxContext) : (u256, 0x2::object::ID) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::decrement_balance(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), arg1, 0x1::type_name::with_defining_ids<T0>(), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun increment_balance<T0: drop>(arg0: &mut Ledger, arg1: T0, arg2: vector<u8>, arg3: u64, arg4: address, arg5: u8, arg6: vector<u8>, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::increment_balance(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), 0x1::type_name::with_defining_ids<T0>(), arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    fun init(arg0: LEDGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = InitCap{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<LEDGER>(arg0, arg1),
        };
        0x2::transfer::transfer<InitCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_app<T0: drop>(arg0: &mut Ledger, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::init_app(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), 0x1::type_name::with_defining_ids<T0>(), arg2);
    }

    public fun initialize(arg0: InitCap, arg1: 0x2::package::UpgradeCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let InitCap {
            id        : v0,
            publisher : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0x2::package::upgrade_package(&arg1);
        assert!(0x2::object::id_to_address(&v2) == @0x0, 9);
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::display::new_and_share(v1, arg3);
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::upgrade::new_and_share(arg1, arg3);
        let v3 = Ledger{
            id         : 0x2::object::new(arg3),
            package_id : 0x2::object::id_to_address(&v2),
            version    : 1,
        };
        let v4 = StateKey{pos0: 1};
        0x2::dynamic_object_field::add<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut v3.id, v4, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::new_state_v1(arg2, arg3));
        0x2::transfer::share_object<Ledger>(v3);
    }

    public fun pause_app<T0: drop>(arg0: &mut Ledger, arg1: &0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::pause_app(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), 0x1::type_name::with_defining_ids<T0>());
    }

    public fun remove_allowed_chain(arg0: &mut Ledger, arg1: &0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::admin::AdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::remove_allowed_chain(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), arg2);
    }

    public fun set_dwallet_network_encryption_key_id(arg0: &mut Ledger, arg1: &0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::admin::AdminCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::set_dwallet_network_encryption_key_id(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), arg2);
    }

    public fun unpause_app<T0: drop>(arg0: &mut Ledger, arg1: &0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::unpause_app(0x2::dynamic_object_field::borrow_mut<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&mut arg0.id, v0), 0x1::type_name::with_defining_ids<T0>());
    }

    public fun user_balance<T0: drop>(arg0: &Ledger, arg1: address, arg2: u8, arg3: vector<u8>) : 0x1::option::Option<u256> {
        let v0 = StateKey{pos0: 1};
        0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::user_balance(0x2::dynamic_object_field::borrow<StateKey, 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::ledger_inner::StateV1>(&arg0.id, v0), 0x1::type_name::with_defining_ids<T0>(), arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

