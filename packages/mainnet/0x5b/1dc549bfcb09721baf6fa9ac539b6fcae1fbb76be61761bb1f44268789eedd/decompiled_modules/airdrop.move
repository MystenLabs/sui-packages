module 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::airdrop {
    struct AirdropLedger has key {
        id: 0x2::object::UID,
        ledger: 0x2::table::Table<address, vector<0x1::type_name::TypeName>>,
    }

    fun add_received_toy<T0: store + key>(arg0: &mut AirdropLedger, arg1: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<address, vector<0x1::type_name::TypeName>>(&arg0.ledger, arg1)) {
            0x2::table::add<address, vector<0x1::type_name::TypeName>>(&mut arg0.ledger, arg1, 0x1::vector::empty<0x1::type_name::TypeName>());
        };
        let v1 = 0x2::table::borrow_mut<address, vector<0x1::type_name::TypeName>>(&mut arg0.ledger, arg1);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(v1, &v0), 0);
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_defining_ids<T0>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropLedger{
            id     : 0x2::object::new(arg0),
            ledger : 0x2::table::new<address, vector<0x1::type_name::TypeName>>(arg0),
        };
        0x2::transfer::share_object<AirdropLedger>(v0);
    }

    public fun receive_airdrop<T0: store + key>(arg0: &mut AirdropLedger, arg1: &mut 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::store::Store, arg2: &mut 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::registry::Registry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::usd_price(0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::registry::borrow_toy<T0>(arg2)) == 0, 1);
        0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::store::transfer<T0>(arg1, arg2, 1, arg3, true, arg4);
        add_received_toy<T0>(arg0, arg3);
    }

    // decompiled from Move bytecode v7
}

