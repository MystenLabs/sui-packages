module 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::lp_registry {
    struct LPRegistry<T0: store + key> has store, key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<0x2::object::ID, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>>,
        owners: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        collector_id: 0x2::object::ID,
    }

    struct Collector<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        vault: 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::vault::Vault,
        fees: 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::vault::Vault,
    }

    struct FeeCollected has copy, drop {
        collector_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        fee_token: 0x1::type_name::TypeName,
        fee_source: u64,
        fee_amount: u64,
    }

    struct AutoPositionOpened has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct AutoPositionClosed has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
    }

    public fun claim_fees<T0: store + key, T1>(arg0: &mut Collector<T0>, arg1: &0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::registry::assert_fee_wallet(arg1, 0x2::tx_context::sender(arg2));
        0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::vault::withdraw_all<T1>(&mut arg0.fees, arg2)
    }

    public fun collect_fees<T0: store + key, T1>(arg0: &mut Collector<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::balance::Balance<T1>, arg5: u64, arg6: u64) {
        let v0 = 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::safe_math::mul_div_u64(0x2::balance::value<T1>(arg4), arg6, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::constants::scaling_pips());
        0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::vault::deposit<T1>(&mut arg0.fees, 0x2::balance::split<T1>(arg4, v0));
        let v1 = FeeCollected{
            collector_id : 0x2::object::uid_to_inner(&arg0.id),
            pool_id      : arg1,
            position_id  : arg2,
            owner        : arg3,
            fee_token    : 0x1::type_name::with_original_ids<T1>(),
            fee_source   : arg5,
            fee_amount   : v0,
        };
        0x2::event::emit<FeeCollected>(v1);
    }

    public fun deposit_vault<T0: store + key, T1>(arg0: &mut Collector<T0>, arg1: &mut 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>, arg2: 0x2::balance::Balance<T1>) {
        let v0 = 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::vault_mut<T0>(arg1);
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x2::vec_map::get_idx_opt<0x1::type_name::TypeName, u64>(v0, &v1);
        if (0x1::option::is_some<u64>(&v2)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u64>(v0, 0x1::option::destroy_some<u64>(v2));
            *v4 = *v4 + 0x2::balance::value<T1>(&arg2);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(v0, v1, 0x2::balance::value<T1>(&arg2));
        };
        0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::vault::deposit<T1>(&mut arg0.vault, arg2);
    }

    public fun fetch_positions<T0: store + key>(arg0: &LPRegistry<T0>, arg1: address) : vector<vector<u8>> {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.owners, arg1)) {
            let v1 = 0x2::vec_set::keys<0x2::object::ID>(0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.owners, arg1));
            let v2 = vector[];
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x2::object::ID>(v1)) {
                0x1::vector::push_back<vector<u8>>(&mut v2, 0x2::bcs::to_bytes<0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>>(0x2::table::borrow<0x2::object::ID, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>>(&arg0.positions, *0x1::vector::borrow<0x2::object::ID>(v1, v3))));
                v3 = v3 + 1;
            };
            v2
        } else {
            0x1::vector::empty<vector<u8>>()
        }
    }

    public fun insert_position<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>, arg2: &0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::registry::ProxyCap) {
        let v0 = 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::owner<T0>(&arg1);
        let v1 = 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::id<T0>(&arg1);
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.owners, v0)) {
            0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.owners, v0), v1);
        } else {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.owners, v0, 0x2::vec_set::singleton<0x2::object::ID>(v1));
        };
        let v2 = AutoPositionOpened{
            position_id : v1,
            owner       : 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::owner<T0>(&arg1),
        };
        0x2::event::emit<AutoPositionOpened>(v2);
        0x2::table::add<0x2::object::ID, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>>(&mut arg0.positions, v1, arg1);
    }

    public fun new_lp_registry<T0: store + key>(arg0: &mut 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::registry::Registry, arg1: &0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::registry::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Collector<T0>{
            id    : 0x2::object::new(arg2),
            vault : 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::vault::new(arg2),
            fees  : 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::vault::new(arg2),
        };
        let v1 = LPRegistry<T0>{
            id           : 0x2::object::new(arg2),
            positions    : 0x2::table::new<0x2::object::ID, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>>(arg2),
            owners       : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2),
            collector_id : 0x2::object::id<Collector<T0>>(&v0),
        };
        0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::registry::register_lp<T0>(arg0, 0x2::object::id<LPRegistry<T0>>(&v1));
        0x2::transfer::share_object<LPRegistry<T0>>(v1);
        0x2::transfer::share_object<Collector<T0>>(v0);
    }

    public fun position_mut<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0x2::object::ID, arg2: &0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::registry::ProxyCap) : &mut 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0> {
        0x2::table::borrow_mut<0x2::object::ID, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>>(&mut arg0.positions, arg1)
    }

    public fun position_mut_by_owner<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : &mut 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0> {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>>(&mut arg0.positions, arg1);
        0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::assert_owner<T0>(v0, 0x2::tx_context::sender(arg2));
        v0
    }

    public fun remove_position<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0x2::object::ID, arg2: &0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::registry::ProxyCap) : 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0> {
        let v0 = 0x2::table::remove<0x2::object::ID, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>>(&mut arg0.positions, arg1);
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.owners, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::owner<T0>(&v0));
        0x2::vec_set::remove<0x2::object::ID>(v1, &arg1);
        if (0x2::vec_set::is_empty<0x2::object::ID>(v1)) {
            0x2::table::remove<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.owners, 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::owner<T0>(&v0));
        };
        let v2 = AutoPositionClosed{
            position_id : arg1,
            owner       : 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::owner<T0>(&v0),
        };
        0x2::event::emit<AutoPositionClosed>(v2);
        v0
    }

    public fun withdraw_vault<T0: store + key, T1>(arg0: &mut Collector<T0>, arg1: &mut 0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::AutoPosition<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::auto_position::vault_mut<T0>(arg1), &v0);
        0xa1d8b2bcb4cd57a8ccc98e18a505cb79dd06731f5a92f2b9711a4ae22bb1aabe::vault::withdraw<T1>(&mut arg0.vault, v2, arg2)
    }

    // decompiled from Move bytecode v6
}

