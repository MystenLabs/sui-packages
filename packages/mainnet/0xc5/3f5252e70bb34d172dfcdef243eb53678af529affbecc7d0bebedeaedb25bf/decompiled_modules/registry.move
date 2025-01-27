module 0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        supply: 0x2::balance::Supply<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>,
        mpoints_burned: 0x2::table::Table<address, u64>,
        total_mpoints_burned: u64,
    }

    public fun burn(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9223372569430720513);
        let v0 = 0x2::coin::value<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>(&arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.mpoints_burned, v1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.mpoints_burned, v1) = *0x2::table::borrow<address, u64>(&arg0.mpoints_burned, v1) + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mpoints_burned, v1, v0);
        };
        arg0.total_mpoints_burned = arg0.total_mpoints_burned + v0;
        0x2::balance::decrease_supply<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>(&mut arg0.supply, 0x2::coin::into_balance<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>(arg1));
    }

    public fun create_registry(arg0: 0x2::coin::TreasuryCap<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::admin::AdminCap>(0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::admin::create_admin_cap(&arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Registry{
            id                   : 0x2::object::new(arg1),
            version              : 0,
            supply               : 0x2::coin::treasury_into_supply<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>(arg0),
            mpoints_burned       : 0x2::table::new<address, u64>(arg1),
            total_mpoints_burned : 0,
        };
        0x2::table::add<address, u64>(&mut v0.mpoints_burned, @0x0, 0);
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun mint(arg0: &0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::admin::AdminCap, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS> {
        assert!(arg1.version == 0, 9223372715459608577);
        0x2::coin::from_balance<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>(0x2::balance::increase_supply<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>(&mut arg1.supply, arg2), arg3)
    }

    public fun mpoints_burned(arg0: &Registry, arg1: address) : &u64 {
        if (0x2::table::contains<address, u64>(&arg0.mpoints_burned, arg1)) {
            0x2::table::borrow<address, u64>(&arg0.mpoints_burned, arg1)
        } else {
            0x2::table::borrow<address, u64>(&arg0.mpoints_burned, @0x0)
        }
    }

    public fun total_mpoints_burned(arg0: &Registry) : u64 {
        arg0.total_mpoints_burned
    }

    public fun total_mpoints_minted(arg0: &Registry) : u64 {
        total_mpoints_not_burned(arg0) + total_mpoints_burned(arg0)
    }

    public fun total_mpoints_not_burned(arg0: &Registry) : u64 {
        0x2::balance::supply_value<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

