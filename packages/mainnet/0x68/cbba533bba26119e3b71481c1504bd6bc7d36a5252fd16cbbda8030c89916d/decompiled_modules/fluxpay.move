module 0x68cbba533bba26119e3b71481c1504bd6bc7d36a5252fd16cbbda8030c89916d::fluxpay {
    struct FluxPayPool has key {
        id: 0x2::object::UID,
        total_volume: u64,
        total_fees: u64,
        total_transactions: u64,
        failed_transactions: u64,
        owner: address,
        pool_address: address,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        escrows: 0x2::table::Table<0x2::object::ID, EscrowInfo>,
        user_history: 0x2::table::Table<address, vector<TransactionRecord>>,
        service_analytics: ServiceAnalytics,
        network_analytics: NetworkAnalytics,
    }

    struct Escrow has store, key {
        id: 0x2::object::UID,
        sender: address,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
        service_type: 0x1::string::String,
        network: 0x1::string::String,
        recipient_identifier: 0x1::string::String,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_at: u64,
        expires_at: u64,
        status: u8,
        tx_hash: 0x1::option::Option<0x1::string::String>,
    }

    struct EscrowInfo has copy, drop, store {
        escrow_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        service_type: 0x1::string::String,
        network: 0x1::string::String,
        created_at: u64,
        status: u8,
    }

    struct TransactionRecord has copy, drop, store {
        tx_id: 0x2::object::ID,
        service_type: 0x1::string::String,
        network: 0x1::string::String,
        amount: u64,
        fee: u64,
        recipient: 0x1::string::String,
        timestamp: u64,
        status: u8,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ServiceAnalytics has copy, drop, store {
        airtime_volume: u64,
        airtime_count: u64,
        data_volume: u64,
        data_count: u64,
        cable_volume: u64,
        cable_count: u64,
        electricity_volume: u64,
        electricity_count: u64,
    }

    struct NetworkAnalytics has copy, drop, store {
        mtn_volume: u64,
        mtn_count: u64,
        glo_volume: u64,
        glo_count: u64,
        airtel_volume: u64,
        airtel_count: u64,
        nine_mobile_volume: u64,
        nine_mobile_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct TransactionReceipt has store, key {
        id: 0x2::object::UID,
        tx_id: 0x2::object::ID,
        user: address,
        service_type: 0x1::string::String,
        network: 0x1::string::String,
        amount: u64,
        fee: u64,
        recipient: 0x1::string::String,
        timestamp: u64,
        status: 0x1::string::String,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        service_type: 0x1::string::String,
        network: 0x1::string::String,
        recipient: 0x1::string::String,
    }

    struct TransactionCompleted has copy, drop {
        tx_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        fee: u64,
        service_type: 0x1::string::String,
        network: 0x1::string::String,
        recipient: 0x1::string::String,
    }

    struct TransactionRefunded has copy, drop {
        escrow_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        reason: 0x1::string::String,
    }

    struct PoolUpdated has copy, drop {
        total_volume: u64,
        total_fees: u64,
        total_transactions: u64,
    }

    public entry fun complete_transaction(arg0: &mut FluxPayPool, arg1: Escrow, arg2: &AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Escrow>(&arg1);
        assert!(0x2::table::contains<0x2::object::ID, EscrowInfo>(&arg0.escrows, v0), 3);
        assert!(arg1.status == 0, 5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 <= arg1.expires_at, 8);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.amount);
        let v3 = v2 * 500 / 10000;
        arg0.total_volume = arg0.total_volume + v2;
        arg0.total_fees = arg0.total_fees + v3;
        arg0.total_transactions = arg0.total_transactions + 1;
        let v4 = &mut arg0.service_analytics;
        update_service_analytics(v4, &arg1.service_type, v2);
        if (arg1.service_type == 0x1::string::utf8(b"airtime") || arg1.service_type == 0x1::string::utf8(b"data")) {
            let v5 = &mut arg0.network_analytics;
            update_network_analytics(v5, &arg1.network, v2);
        };
        let v6 = TransactionRecord{
            tx_id        : v0,
            service_type : arg1.service_type,
            network      : arg1.network,
            amount       : v2,
            fee          : v3,
            recipient    : arg1.recipient_identifier,
            timestamp    : v1,
            status       : 1,
            metadata     : arg1.metadata,
        };
        if (!0x2::table::contains<address, vector<TransactionRecord>>(&arg0.user_history, arg1.sender)) {
            0x2::table::add<address, vector<TransactionRecord>>(&mut arg0.user_history, arg1.sender, 0x1::vector::empty<TransactionRecord>());
        };
        0x1::vector::push_back<TransactionRecord>(0x2::table::borrow_mut<address, vector<TransactionRecord>>(&mut arg0.user_history, arg1.sender), v6);
        let v7 = TransactionReceipt{
            id           : 0x2::object::new(arg4),
            tx_id        : v0,
            user         : arg1.sender,
            service_type : arg1.service_type,
            network      : arg1.network,
            amount       : v2,
            fee          : v3,
            recipient    : arg1.recipient_identifier,
            timestamp    : v1,
            status       : 0x1::string::utf8(b"completed"),
        };
        0x2::transfer::transfer<TransactionReceipt>(v7, arg1.sender);
        let Escrow {
            id                   : v8,
            sender               : v9,
            amount               : v10,
            service_type         : v11,
            network              : v12,
            recipient_identifier : v13,
            metadata             : _,
            created_at           : _,
            expires_at           : _,
            status               : _,
            tx_hash              : _,
        } = arg1;
        let v19 = v10;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v19, v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v19, arg4), arg0.pool_address);
        0x2::table::borrow_mut<0x2::object::ID, EscrowInfo>(&mut arg0.escrows, v0).status = 1;
        let v20 = TransactionCompleted{
            tx_id        : v0,
            sender       : v9,
            amount       : v2,
            fee          : v3,
            service_type : v11,
            network      : v12,
            recipient    : v13,
        };
        0x2::event::emit<TransactionCompleted>(v20);
        let v21 = PoolUpdated{
            total_volume       : arg0.total_volume,
            total_fees         : arg0.total_fees,
            total_transactions : arg0.total_transactions,
        };
        0x2::event::emit<PoolUpdated>(v21);
        0x2::object::delete(v8);
    }

    public entry fun create_escrow(arg0: &mut FluxPayPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 300000, 1);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::object::new(arg6);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = 0x1::string::utf8(arg2);
        let v6 = 0x1::string::utf8(arg3);
        let v7 = 0x1::string::utf8(arg4);
        let v8 = if (v5 == 0x1::string::utf8(b"airtime")) {
            true
        } else if (v5 == 0x1::string::utf8(b"data")) {
            true
        } else if (v5 == 0x1::string::utf8(b"cable")) {
            true
        } else {
            v5 == 0x1::string::utf8(b"electricity")
        };
        assert!(v8, 6);
        let v9 = Escrow{
            id                   : v2,
            sender               : v1,
            amount               : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            service_type         : v5,
            network              : v6,
            recipient_identifier : v7,
            metadata             : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            created_at           : v4,
            expires_at           : v4 + 86400000,
            status               : 0,
            tx_hash              : 0x1::option::none<0x1::string::String>(),
        };
        let v10 = EscrowInfo{
            escrow_id    : v3,
            sender       : v1,
            amount       : v0,
            service_type : v5,
            network      : v6,
            created_at   : v4,
            status       : 0,
        };
        0x2::table::add<0x2::object::ID, EscrowInfo>(&mut arg0.escrows, v3, v10);
        let v11 = EscrowCreated{
            escrow_id    : v3,
            sender       : v1,
            amount       : v0,
            service_type : v5,
            network      : v6,
            recipient    : v7,
        };
        0x2::event::emit<EscrowCreated>(v11);
        0x2::transfer::transfer<Escrow>(v9, v1);
    }

    public fun get_escrow_status(arg0: &FluxPayPool, arg1: 0x2::object::ID) : 0x1::option::Option<EscrowInfo> {
        if (0x2::table::contains<0x2::object::ID, EscrowInfo>(&arg0.escrows, arg1)) {
            0x1::option::some<EscrowInfo>(*0x2::table::borrow<0x2::object::ID, EscrowInfo>(&arg0.escrows, arg1))
        } else {
            0x1::option::none<EscrowInfo>()
        }
    }

    public fun get_network_analytics(arg0: &FluxPayPool) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = &arg0.network_analytics;
        (v0.mtn_volume, v0.mtn_count, v0.glo_volume, v0.glo_count, v0.airtel_volume, v0.airtel_count, v0.nine_mobile_volume, v0.nine_mobile_count)
    }

    public fun get_pool_stats(arg0: &FluxPayPool) : (u64, u64, u64, u64) {
        (arg0.total_volume, arg0.total_fees, arg0.total_transactions, arg0.failed_transactions)
    }

    public fun get_service_analytics(arg0: &FluxPayPool) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = &arg0.service_analytics;
        (v0.airtime_volume, v0.airtime_count, v0.data_volume, v0.data_count, v0.cable_volume, v0.cable_count, v0.electricity_volume, v0.electricity_count)
    }

    public fun get_user_history(arg0: &FluxPayPool, arg1: address) : vector<TransactionRecord> {
        if (0x2::table::contains<address, vector<TransactionRecord>>(&arg0.user_history, arg1)) {
            *0x2::table::borrow<address, vector<TransactionRecord>>(&arg0.user_history, arg1)
        } else {
            0x1::vector::empty<TransactionRecord>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ServiceAnalytics{
            airtime_volume     : 0,
            airtime_count      : 0,
            data_volume        : 0,
            data_count         : 0,
            cable_volume       : 0,
            cable_count        : 0,
            electricity_volume : 0,
            electricity_count  : 0,
        };
        let v1 = NetworkAnalytics{
            mtn_volume         : 0,
            mtn_count          : 0,
            glo_volume         : 0,
            glo_count          : 0,
            airtel_volume      : 0,
            airtel_count       : 0,
            nine_mobile_volume : 0,
            nine_mobile_count  : 0,
        };
        let v2 = FluxPayPool{
            id                  : 0x2::object::new(arg0),
            total_volume        : 0,
            total_fees          : 0,
            total_transactions  : 0,
            failed_transactions : 0,
            owner               : 0x2::tx_context::sender(arg0),
            pool_address        : 0x2::tx_context::sender(arg0),
            fee_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            escrows             : 0x2::table::new<0x2::object::ID, EscrowInfo>(arg0),
            user_history        : 0x2::table::new<address, vector<TransactionRecord>>(arg0),
            service_analytics   : v0,
            network_analytics   : v1,
        };
        let v3 = AdminCap{
            id      : 0x2::object::new(arg0),
            pool_id : 0x2::object::id<FluxPayPool>(&v2),
        };
        0x2::transfer::share_object<FluxPayPool>(v2);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public entry fun refund_transaction(arg0: &mut FluxPayPool, arg1: Escrow, arg2: vector<u8>, arg3: &AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Escrow>(&arg1);
        assert!(0x2::table::contains<0x2::object::ID, EscrowInfo>(&arg0.escrows, v0), 3);
        assert!(arg1.status == 0, 5);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.amount);
        arg0.failed_transactions = arg0.failed_transactions + 1;
        let v2 = TransactionRecord{
            tx_id        : v0,
            service_type : arg1.service_type,
            network      : arg1.network,
            amount       : v1,
            fee          : 0,
            recipient    : arg1.recipient_identifier,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
            status       : 2,
            metadata     : arg1.metadata,
        };
        if (!0x2::table::contains<address, vector<TransactionRecord>>(&arg0.user_history, arg1.sender)) {
            0x2::table::add<address, vector<TransactionRecord>>(&mut arg0.user_history, arg1.sender, 0x1::vector::empty<TransactionRecord>());
        };
        0x1::vector::push_back<TransactionRecord>(0x2::table::borrow_mut<address, vector<TransactionRecord>>(&mut arg0.user_history, arg1.sender), v2);
        let Escrow {
            id                   : v3,
            sender               : v4,
            amount               : v5,
            service_type         : _,
            network              : _,
            recipient_identifier : _,
            metadata             : _,
            created_at           : _,
            expires_at           : _,
            status               : _,
            tx_hash              : _,
        } = arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg5), v4);
        0x2::table::borrow_mut<0x2::object::ID, EscrowInfo>(&mut arg0.escrows, v0).status = 2;
        let v14 = TransactionRefunded{
            escrow_id : v0,
            sender    : v4,
            amount    : v1,
            reason    : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<TransactionRefunded>(v14);
        0x2::object::delete(v3);
    }

    fun update_network_analytics(arg0: &mut NetworkAnalytics, arg1: &0x1::string::String, arg2: u64) {
        if (*arg1 == 0x1::string::utf8(b"MTN")) {
            arg0.mtn_volume = arg0.mtn_volume + arg2;
            arg0.mtn_count = arg0.mtn_count + 1;
        } else if (*arg1 == 0x1::string::utf8(b"GLO")) {
            arg0.glo_volume = arg0.glo_volume + arg2;
            arg0.glo_count = arg0.glo_count + 1;
        } else if (*arg1 == 0x1::string::utf8(b"Airtel")) {
            arg0.airtel_volume = arg0.airtel_volume + arg2;
            arg0.airtel_count = arg0.airtel_count + 1;
        } else if (*arg1 == 0x1::string::utf8(b"9Mobile")) {
            arg0.nine_mobile_volume = arg0.nine_mobile_volume + arg2;
            arg0.nine_mobile_count = arg0.nine_mobile_count + 1;
        };
    }

    public entry fun update_pool_address(arg0: &mut FluxPayPool, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.pool_address = arg1;
    }

    fun update_service_analytics(arg0: &mut ServiceAnalytics, arg1: &0x1::string::String, arg2: u64) {
        if (*arg1 == 0x1::string::utf8(b"airtime")) {
            arg0.airtime_volume = arg0.airtime_volume + arg2;
            arg0.airtime_count = arg0.airtime_count + 1;
        } else if (*arg1 == 0x1::string::utf8(b"data")) {
            arg0.data_volume = arg0.data_volume + arg2;
            arg0.data_count = arg0.data_count + 1;
        } else if (*arg1 == 0x1::string::utf8(b"cable")) {
            arg0.cable_volume = arg0.cable_volume + arg2;
            arg0.cable_count = arg0.cable_count + 1;
        } else if (*arg1 == 0x1::string::utf8(b"electricity")) {
            arg0.electricity_volume = arg0.electricity_volume + arg2;
            arg0.electricity_count = arg0.electricity_count + 1;
        };
    }

    public entry fun withdraw_fees(arg0: &mut FluxPayPool, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee_balance, v0), arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

