module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher {
    struct TransferDetails has copy, drop, store {
        vault_id: address,
        product_id: address,
        product_category: u64,
    }

    struct DispatcherRecord has store {
        balance: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        creator: u64,
        source: TransferDetails,
        target: TransferDetails,
    }

    struct DispatcherCreated has copy, drop {
        id: address,
    }

    struct Dispatcher has store, key {
        id: 0x2::object::UID,
        queue: vector<u256>,
        data: 0x2::table::Table<u256, DispatcherRecord>,
    }

    public(friend) fun empty(arg0: &mut Dispatcher) {
        let v0 = arg0.queue;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&v0)) {
            let DispatcherRecord {
                balance : _,
                creator : _,
                source  : _,
                target  : _,
            } = 0x2::table::remove<u256, DispatcherRecord>(&mut arg0.data, *0x1::vector::borrow<u256>(&v0, v1));
            v1 = v1 + 1;
        };
        arg0.queue = 0x1::vector::empty<u256>();
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Dispatcher{
            id    : v0,
            queue : 0x1::vector::empty<u256>(),
            data  : 0x2::table::new<u256, DispatcherRecord>(arg0),
        };
        let v2 = DispatcherCreated{id: 0x2::object::uid_to_address(&v0)};
        0x2::event::emit<DispatcherCreated>(v2);
        0x2::transfer::public_share_object<Dispatcher>(v1);
    }

    public(friend) fun add_record(arg0: &mut Dispatcher, arg1: &TransferDetails, arg2: &TransferDetails, arg3: u64, arg4: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg5: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg6: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal) {
        let v0 = dispatch_record_id(arg1, arg2, &arg3);
        let v1 = dispatch_record_id(arg2, arg1, &arg3);
        let v2 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(arg4, arg5);
        if (0x2::table::contains<u256, DispatcherRecord>(&arg0.data, v0)) {
            let v3 = 0x2::table::borrow_mut<u256, DispatcherRecord>(&mut arg0.data, v0);
            v3.balance = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::add(v3.balance, arg4);
        } else if (0x2::table::contains<u256, DispatcherRecord>(&arg0.data, v1)) {
            let v4 = 0x2::table::borrow_mut<u256, DispatcherRecord>(&mut arg0.data, v1);
            let v5 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v4.balance, arg6);
            if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::ge(v5, v2)) {
                v4.balance = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v5, v2), arg6);
                if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::is_zero(v4.balance)) {
                    let (_, _) = remove_record(arg0, v1);
                };
            } else {
                let (v8, v9) = remove_record(arg0, v1);
                let v10 = DispatcherRecord{
                    balance : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v8, arg6)), arg5),
                    creator : arg3,
                    source  : *arg1,
                    target  : *arg2,
                };
                0x2::table::add<u256, DispatcherRecord>(&mut arg0.data, v0, v10);
                0x1::vector::insert<u256>(&mut arg0.queue, v0, v9);
            };
        } else {
            let v11 = DispatcherRecord{
                balance : arg4,
                creator : arg3,
                source  : *arg1,
                target  : *arg2,
            };
            0x2::table::add<u256, DispatcherRecord>(&mut arg0.data, v0, v11);
            0x1::vector::push_back<u256>(&mut arg0.queue, v0);
        };
    }

    public fun dispatch<T0>(arg0: &mut Dispatcher, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::borrow::BorrowReceipt, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::remove<u256>(&mut arg0.queue, 0);
        dispatch_internal<T0>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun dispatch_internal<T0>(arg0: &mut Dispatcher, arg1: u256, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg5: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::borrow::BorrowReceipt, 0x2::coin::Coin<T0>) {
        let DispatcherRecord {
            balance : v0,
            creator : v1,
            source  : v2,
            target  : v3,
        } = 0x2::table::remove<u256, DispatcherRecord>(&mut arg0.data, arg1);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg5);
        assert!(0x2::object::id_to_address(&v6) == v5.vault_id, 500);
        let v7 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::balance_amount<T0>(arg5, arg2, v5.product_id);
        let v8 = if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::gt(v0, v7)) {
            v7
        } else {
            v0
        };
        let v9 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v9, v4.vault_id);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::borrow::create_receipt<T0>(arg5, v1, arg2, arg3, arg4, v9, v8, v5.product_id, v5.product_category, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero(), arg6, arg7)
    }

    fun dispatch_record_id(arg0: &TransferDetails, arg1: &TransferDetails, arg2: &u64) : u256 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<TransferDetails>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<TransferDetails>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(arg2));
        vector_to_u256(0x1::hash::sha3_256(v0))
    }

    public(friend) fun new_transfer_details(arg0: address, arg1: address, arg2: u64) : TransferDetails {
        TransferDetails{
            vault_id         : arg0,
            product_id       : arg1,
            product_category : arg2,
        }
    }

    fun remove_record(arg0: &mut Dispatcher, arg1: u256) : (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, u64) {
        let DispatcherRecord {
            balance : v0,
            creator : _,
            source  : _,
            target  : _,
        } = 0x2::table::remove<u256, DispatcherRecord>(&mut arg0.data, arg1);
        let (_, v5) = 0x1::vector::index_of<u256>(&arg0.queue, &arg1);
        0x1::vector::remove<u256>(&mut arg0.queue, v5);
        (v0, v5)
    }

    fun vector_to_u256(arg0: vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(&arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

