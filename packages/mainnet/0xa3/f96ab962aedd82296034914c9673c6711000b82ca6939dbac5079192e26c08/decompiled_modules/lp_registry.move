module 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry {
    struct LPRegistry<T0: store + key> has store, key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<0x2::object::ID, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>>,
        owners: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        fee_collector_id: 0x2::object::ID,
    }

    struct FeeCollector<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        vault: 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::Vault,
    }

    struct FeeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        fee_collector_id: 0x2::object::ID,
        fee_token: 0x1::type_name::TypeName,
        fee_source: u64,
        fee_amount: u64,
    }

    public fun claim_fees<T0: store + key, T1>(arg0: &mut FeeCollector<T0>, arg1: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::assert_fee_wallet(arg1, 0x2::tx_context::sender(arg2));
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::withdraw_all<T1>(&mut arg0.vault, arg2)
    }

    public fun collect_fees<T0: store + key, T1>(arg0: &mut FeeCollector<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::balance::Balance<T1>, arg3: u64, arg4: u64) {
        let v0 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::safe_math::mul_div_u64(0x2::balance::value<T1>(arg2), arg4, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::scaling_pips());
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::deposit<T1>(&mut arg0.vault, 0x2::balance::split<T1>(arg2, v0));
        let v1 = FeeCollected{
            pool_id          : arg1,
            fee_collector_id : 0x2::object::uid_to_inner(&arg0.id),
            fee_token        : 0x1::type_name::get<T1>(),
            fee_source       : arg3,
            fee_amount       : v0,
        };
        0x2::event::emit<FeeCollected>(v1);
    }

    public fun fetch_positions<T0: store + key>(arg0: &LPRegistry<T0>, arg1: address) : vector<vector<u8>> {
        let v0 = 0x2::vec_set::keys<0x2::object::ID>(0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.owners, arg1));
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v0)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x2::bcs::to_bytes<0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>>(0x2::table::borrow<0x2::object::ID, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>>(&arg0.positions, *0x1::vector::borrow<0x2::object::ID>(v0, v2))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun insert_position<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>, arg2: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap) {
        let v0 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::owner<T0>(&arg1);
        let v1 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::id<T0>(&arg1);
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.owners, v0)) {
            0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.owners, v0), v1);
        } else {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.owners, v0, 0x2::vec_set::singleton<0x2::object::ID>(v1));
        };
        0x2::table::add<0x2::object::ID, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>>(&mut arg0.positions, v1, arg1);
    }

    public fun new_lp_registry<T0: store + key>(arg0: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollector<T0>{
            id    : 0x2::object::new(arg2),
            vault : 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::new(arg2),
        };
        let v1 = LPRegistry<T0>{
            id               : 0x2::object::new(arg2),
            positions        : 0x2::table::new<0x2::object::ID, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>>(arg2),
            owners           : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2),
            fee_collector_id : 0x2::object::id<FeeCollector<T0>>(&v0),
        };
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::register_lp<T0>(arg0, 0x2::object::id<LPRegistry<T0>>(&v1), arg1);
        0x2::transfer::share_object<LPRegistry<T0>>(v1);
        0x2::transfer::share_object<FeeCollector<T0>>(v0);
    }

    public fun position_mut<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0x2::object::ID, arg2: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap) : &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0> {
        0x2::table::borrow_mut<0x2::object::ID, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>>(&mut arg0.positions, arg1)
    }

    public fun position_mut_by_owner<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0> {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>>(&mut arg0.positions, arg1);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::assert_owner<T0>(v0, 0x2::tx_context::sender(arg2));
        v0
    }

    fun remove_position<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0x2::object::ID) : 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0> {
        let v0 = 0x2::table::remove<0x2::object::ID, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<T0>>(&mut arg0.positions, arg1);
        let v1 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::id<T0>(&v0);
        0x2::vec_set::remove<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.owners, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::owner<T0>(&v0)), &v1);
        v0
    }

    public fun unwrap_position<T0: store + key>(arg0: &mut LPRegistry<T0>, arg1: 0x2::object::ID, arg2: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap) : (address, T0, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::Vault) {
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::unwrap<T0>(remove_position<T0>(arg0, arg1))
    }

    // decompiled from Move bytecode v6
}

