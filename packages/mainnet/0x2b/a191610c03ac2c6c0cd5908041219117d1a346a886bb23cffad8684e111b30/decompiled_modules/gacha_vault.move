module 0x2ba191610c03ac2c6c0cd5908041219117d1a346a886bb23cffad8684e111b30::gacha_vault {
    struct GachaVault<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        box: 0x2::table_vec::TableVec<T0>,
        box_indexes: 0x2::table::Table<0x2::object::ID, u64>,
    }

    public(friend) fun length<T0: store + key>(arg0: &GachaVault<T0>) : u64 {
        0x2::table_vec::length<T0>(&arg0.box)
    }

    public(friend) fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : GachaVault<T0> {
        GachaVault<T0>{
            id          : 0x2::object::new(arg0),
            box         : 0x2::table_vec::empty<T0>(arg0),
            box_indexes : 0x2::table::new<0x2::object::ID, u64>(arg0),
        }
    }

    public(friend) fun add<T0: store + key>(arg0: &mut GachaVault<T0>, arg1: T0) {
        0x2::table_vec::push_back<T0>(&mut arg0.box, arg1);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.box_indexes, 0x2::object::id<T0>(&arg1), 0x2::table_vec::length<T0>(&arg0.box));
    }

    public(friend) fun remove_by_id<T0: store + key>(arg0: &mut GachaVault<T0>, arg1: 0x2::object::ID) : T0 {
        let v0 = 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.box_indexes, arg1);
        if (v0 < 0x2::table_vec::length<T0>(&arg0.box)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.box_indexes, 0x2::object::id<T0>(0x2::table_vec::borrow<T0>(&arg0.box, v0))) = v0;
        };
        0x2::table_vec::swap_remove<T0>(&mut arg0.box, v0)
    }

    public(friend) fun remove_by_index<T0: store + key>(arg0: &mut GachaVault<T0>, arg1: u64) : T0 {
        let v0 = 0x2::table_vec::swap_remove<T0>(&mut arg0.box, arg1);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.box_indexes, 0x2::object::id<T0>(&v0));
        if (arg1 < 0x2::table_vec::length<T0>(&arg0.box)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.box_indexes, 0x2::object::id<T0>(0x2::table_vec::borrow<T0>(&arg0.box, arg1))) = arg1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

