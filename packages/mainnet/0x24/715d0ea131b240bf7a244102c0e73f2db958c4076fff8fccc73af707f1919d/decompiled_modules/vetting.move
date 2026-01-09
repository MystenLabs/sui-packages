module 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::vetting {
    struct VettingTable has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, bool>,
    }

    public entry fun approve_vetting(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::cap::AdminCap, arg1: &mut VettingTable, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg1.records, arg2), 0);
        *0x2::table::borrow_mut<address, bool>(&mut arg1.records, arg2) = true;
        0x2::transfer::public_transfer<0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::braav_public::CreatorCap>(0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::braav_public::mint_creator_cap(arg0, arg3), arg2);
    }

    public entry fun initialize_vetting_table(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VettingTable{
            id      : 0x2::object::new(arg1),
            records : 0x2::table::new<address, bool>(arg1),
        };
        0x2::table::add<address, bool>(&mut v0.records, 0x2::tx_context::sender(arg1), true);
        0x2::transfer::share_object<VettingTable>(v0);
    }

    public fun status_of_vetting(arg0: &VettingTable, arg1: address) : 0x1::option::Option<bool> {
        if (0x2::table::contains<address, bool>(&arg0.records, arg1)) {
            0x1::option::some<bool>(*0x2::table::borrow<address, bool>(&arg0.records, arg1))
        } else {
            0x1::option::none<bool>()
        }
    }

    public entry fun submit_for_vetting(arg0: &mut VettingTable, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, bool>(&arg0.records, v0)) {
            0x2::table::add<address, bool>(&mut arg0.records, v0, false);
        };
    }

    // decompiled from Move bytecode v6
}

