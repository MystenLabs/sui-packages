module 0xb8ed9253c8c4b8f21eefbbccdda6f87940be360afaba78045a460bbe1881b98f::gacha_vault {
    struct GachaVault<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        box: 0x2::table_vec::TableVec<0x2::object::ID>,
        box_indexes: 0x2::table::Table<0x2::object::ID, u64>,
        inventory: 0x2::table::Table<0x2::object::ID, T0>,
    }

    public(friend) fun length<T0: store + key>(arg0: &GachaVault<T0>) : u64 {
        0x2::table_vec::length<0x2::object::ID>(&arg0.box)
    }

    public(friend) fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : GachaVault<T0> {
        GachaVault<T0>{
            id          : 0x2::object::new(arg0),
            box         : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            box_indexes : 0x2::table::new<0x2::object::ID, u64>(arg0),
            inventory   : 0x2::table::new<0x2::object::ID, T0>(arg0),
        }
    }

    public(friend) fun add<T0: store + key>(arg0: &mut GachaVault<T0>, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::table::add<0x2::object::ID, T0>(&mut arg0.inventory, v0, arg1);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.box, v0);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.box_indexes, v0, 0x2::table_vec::length<0x2::object::ID>(&arg0.box));
    }

    public(friend) fun remove_by_id<T0: store + key>(arg0: &mut GachaVault<T0>, arg1: 0x2::object::ID) : T0 {
        0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg0.box, 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.box_indexes, arg1));
        0x2::table::remove<0x2::object::ID, T0>(&mut arg0.inventory, arg1)
    }

    public(friend) fun remove_by_index<T0: store + key>(arg0: &mut GachaVault<T0>, arg1: u64) : T0 {
        let v0 = 0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg0.box, arg1);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.box_indexes, v0);
        0x2::table::remove<0x2::object::ID, T0>(&mut arg0.inventory, v0)
    }

    // decompiled from Move bytecode v6
}

