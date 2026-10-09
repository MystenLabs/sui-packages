module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool {
    struct UtxoRecord has store {
        utxo: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo,
        produced_by: 0x1::option::Option<address>,
        spent_by: 0x1::option::Option<address>,
        spent_epoch: 0x1::option::Option<u64>,
    }

    struct UtxoPool has store {
        utxo_records: 0x2::bag::Bag,
        spent_utxos: 0x2::bag::Bag,
    }

    struct UtxoSpent has copy, drop {
        utxo_id: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId,
        spent_epoch: u64,
    }

    public(friend) fun assert_not_spent_or_active(arg0: &UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId) {
        assert!(!is_spent_or_active(arg0, arg1), 13906834668264751107);
    }

    public(friend) fun cleanup_spent(arg0: &mut UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId) {
        if (0x2::bag::contains<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&arg0.utxo_records, arg1)) {
            let UtxoRecord {
                utxo        : v0,
                produced_by : _,
                spent_by    : _,
                spent_epoch : v3,
            } = 0x2::bag::remove<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, UtxoRecord>(&mut arg0.utxo_records, arg1);
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::delete(v0);
            0x2::bag::add<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, u64>(&mut arg0.spent_utxos, arg1, 0x1::option::destroy_some<u64>(v3));
        };
    }

    public(friend) fun confirm_pending(arg0: &mut UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId) {
        if (0x2::bag::contains<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&arg0.utxo_records, arg1)) {
            0x2::bag::borrow_mut<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, UtxoRecord>(&mut arg0.utxo_records, arg1).produced_by = 0x1::option::none<address>();
        };
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : UtxoPool {
        UtxoPool{
            utxo_records : 0x2::bag::new(arg0),
            spent_utxos  : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun get_utxo(arg0: &UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId) : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo {
        0x2::bag::borrow<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, UtxoRecord>(&arg0.utxo_records, arg1).utxo
    }

    public(friend) fun insert_active(arg0: &mut UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo) {
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::id(&arg1);
        assert_not_spent_or_active(arg0, v0);
        let v1 = UtxoRecord{
            utxo        : arg1,
            produced_by : 0x1::option::none<address>(),
            spent_by    : 0x1::option::none<address>(),
            spent_epoch : 0x1::option::none<u64>(),
        };
        0x2::bag::add<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, UtxoRecord>(&mut arg0.utxo_records, v0, v1);
    }

    public(friend) fun insert_pending(arg0: &mut UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo, arg2: address) {
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::id(&arg1);
        assert_not_spent_or_active(arg0, v0);
        let v1 = UtxoRecord{
            utxo        : arg1,
            produced_by : 0x1::option::some<address>(arg2),
            spent_by    : 0x1::option::none<address>(),
            spent_epoch : 0x1::option::none<u64>(),
        };
        0x2::bag::add<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, UtxoRecord>(&mut arg0.utxo_records, v0, v1);
    }

    public(friend) fun is_spent_or_active(arg0: &UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId) : bool {
        0x2::bag::contains<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&arg0.utxo_records, arg1) || 0x2::bag::contains<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&arg0.spent_utxos, arg1)
    }

    public(friend) fun lock(arg0: &mut UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, arg2: address) {
        let v0 = 0x2::bag::borrow_mut<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, UtxoRecord>(&mut arg0.utxo_records, arg1);
        assert!(0x1::option::is_none<address>(&v0.spent_by), 13906834719804227585);
        v0.spent_by = 0x1::option::some<address>(arg2);
    }

    public(friend) fun mark_spent(arg0: &mut UtxoPool, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, arg2: u64) {
        0x2::bag::borrow_mut<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId, UtxoRecord>(&mut arg0.utxo_records, arg1).spent_epoch = 0x1::option::some<u64>(arg2);
        let v0 = UtxoSpent{
            utxo_id     : arg1,
            spent_epoch : arg2,
        };
        0x2::event::emit<UtxoSpent>(v0);
    }

    // decompiled from Move bytecode v7
}

