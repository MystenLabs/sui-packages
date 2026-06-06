module 0x821fe59883352cc3007fb68a05421e03e338594a13746845143dc4f01820e8ad::attestor {
    struct Order has key {
        id: 0x2::object::UID,
        payer: address,
        worker: address,
        payment: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        vault_id: 0x2::object::ID,
        committed_blob_id: u256,
        required_horizon: u32,
        deadline_epoch: u32,
        state: u8,
        ticket: 0x1::option::Option<0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::ObligationTicket>,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        payer: address,
        worker: address,
        vault_id: 0x2::object::ID,
        committed_blob_id: u256,
        amount: u64,
        required_horizon: u32,
        deadline_epoch: u32,
    }

    struct Delivered has copy, drop {
        order_id: 0x2::object::ID,
        worker: address,
        amount: u64,
        vault_id: 0x2::object::ID,
        version: u64,
    }

    struct Refunded has copy, drop {
        order_id: 0x2::object::ID,
        payer: address,
        amount: u64,
    }

    public fun accept_delivery(arg0: &mut Order, arg1: &mut 0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::EternityVault, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 7);
        assert!(0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::vault_id(arg1) == arg0.vault_id, 1);
        assert!(0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::is_certified_live(arg1, arg2), 2);
        assert!(0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::committed_blob_id(arg1) == arg0.committed_blob_id, 3);
        assert!(0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::live_through_epoch(arg1) >= arg0.required_horizon, 4);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2) <= arg0.deadline_epoch, 5);
        let v0 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.payment);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.payment, v0, arg3), arg0.worker);
        arg0.state = 1;
        0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::unlock_obligation(arg1, 0x1::option::extract<0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::ObligationTicket>(&mut arg0.ticket));
        let v1 = Delivered{
            order_id : 0x2::object::uid_to_inner(&arg0.id),
            worker   : arg0.worker,
            amount   : v0,
            vault_id : arg0.vault_id,
            version  : 0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::receipt_version(arg1),
        };
        0x2::event::emit<Delivered>(v1);
    }

    public fun create_order(arg0: &mut 0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::EternityVault, arg1: address, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: u256, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::lock_obligation(arg0);
        let v1 = 0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::ticket_vault_id(&v0);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::object::new(arg6);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Order{
            id                : v3,
            payer             : v2,
            worker            : arg1,
            payment           : 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2),
            vault_id          : v1,
            committed_blob_id : arg3,
            required_horizon  : arg4,
            deadline_epoch    : arg5,
            state             : 0,
            ticket            : 0x1::option::some<0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::ObligationTicket>(v0),
        };
        let v6 = OrderCreated{
            order_id          : v4,
            payer             : v2,
            worker            : arg1,
            vault_id          : v1,
            committed_blob_id : arg3,
            amount            : 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2),
            required_horizon  : arg4,
            deadline_epoch    : arg5,
        };
        0x2::event::emit<OrderCreated>(v6);
        0x2::transfer::share_object<Order>(v5);
        v4
    }

    public fun order_amount(arg0: &Order) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.payment)
    }

    public fun order_blob_id(arg0: &Order) : u256 {
        arg0.committed_blob_id
    }

    public fun order_state(arg0: &Order) : u8 {
        arg0.state
    }

    public fun order_vault(arg0: &Order) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun refund_on_timeout(arg0: &mut Order, arg1: &mut 0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::EternityVault, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 7);
        assert!(0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::vault_id(arg1) == arg0.vault_id, 1);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2) > arg0.deadline_epoch, 6);
        let v0 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.payment);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.payment, v0, arg3), arg0.payer);
        arg0.state = 2;
        0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::unlock_obligation(arg1, 0x1::option::extract<0xd2440abcf89e0aab9506e5cd54e0594039e823c9b631134e56c63db728ee078e::eternity_vault::ObligationTicket>(&mut arg0.ticket));
        let v1 = Refunded{
            order_id : 0x2::object::uid_to_inner(&arg0.id),
            payer    : arg0.payer,
            amount   : v0,
        };
        0x2::event::emit<Refunded>(v1);
    }

    // decompiled from Move bytecode v7
}

