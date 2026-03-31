module 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        launches: 0x2::table::Table<0x2::object::ID, LaunchRecord>,
        creator_launches: 0x2::table::Table<address, vector<0x2::object::ID>>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_launches: u64,
        total_peg_volume_sui: u64,
    }

    struct LaunchRecord has store {
        anchor_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        creator: address,
        peg_sui: u64,
        k: u128,
        launched_at: u64,
    }

    struct LaunchRegistered has copy, drop {
        anchor_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        creator: address,
        peg_sui: u64,
        k: u128,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun deposit_fee(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                   : 0x2::object::new(arg0),
            launches             : 0x2::table::new<0x2::object::ID, LaunchRecord>(arg0),
            creator_launches     : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_launches       : 0,
            total_peg_volume_sui : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun register(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: address, arg4: u64, arg5: u128, arg6: u64) {
        let v0 = LaunchRecord{
            anchor_id   : arg1,
            token_type  : arg2,
            creator     : arg3,
            peg_sui     : arg4,
            k           : arg5,
            launched_at : arg6,
        };
        0x2::table::add<0x2::object::ID, LaunchRecord>(&mut arg0.launches, arg1, v0);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.creator_launches, arg3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.creator_launches, arg3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.creator_launches, arg3), arg1);
        arg0.total_launches = arg0.total_launches + 1;
        arg0.total_peg_volume_sui = arg0.total_peg_volume_sui + arg4;
        let v1 = LaunchRegistered{
            anchor_id  : arg1,
            token_type : arg2,
            creator    : arg3,
            peg_sui    : arg4,
            k          : arg5,
        };
        0x2::event::emit<LaunchRegistered>(v1);
    }

    public fun total_launches(arg0: &Registry) : u64 {
        arg0.total_launches
    }

    public fun total_peg_volume_sui(arg0: &Registry) : u64 {
        arg0.total_peg_volume_sui
    }

    public fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

