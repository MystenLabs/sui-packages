module 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::deal {
    struct DataUnit has store, key {
        id: 0x2::object::UID,
        consumer: address,
        provider: address,
        provider_id: 0x2::object::ID,
        capacity_gb: u64,
        duration_days: u64,
        price_per_gb_per_month: u64,
        total_amount: u64,
        escrowed_funds: 0x2::balance::Balance<0x2::sui::SUI>,
        fb_deal_id: vector<u8>,
        start_timestamp: u64,
        end_timestamp: u64,
        status: u8,
        currency_type: u8,
        walrus_metadata_blob_id: vector<u8>,
        qos_stats_id: 0x2::object::ID,
        created_at: u64,
        updated_at: u64,
    }

    struct DataUnitUSDC<phantom T0> has store, key {
        id: 0x2::object::UID,
        consumer: address,
        provider: address,
        provider_id: 0x2::object::ID,
        capacity_gb: u64,
        duration_days: u64,
        price_per_gb_per_month: u64,
        total_amount: u64,
        escrowed_funds: 0x2::balance::Balance<T0>,
        fb_deal_id: vector<u8>,
        start_timestamp: u64,
        end_timestamp: u64,
        status: u8,
        currency_type: u8,
        walrus_metadata_blob_id: vector<u8>,
        qos_stats_id: 0x2::object::ID,
        created_at: u64,
        updated_at: u64,
    }

    struct DealCreated has copy, drop {
        deal_id: 0x2::object::ID,
        consumer: address,
        provider: address,
        capacity_gb: u64,
        total_amount: u64,
        duration_days: u64,
        currency_type: u8,
    }

    struct DealCompleted has copy, drop {
        deal_id: 0x2::object::ID,
        amount_paid: u64,
        currency_type: u8,
    }

    struct DealRefunded has copy, drop {
        deal_id: 0x2::object::ID,
        refund_amount: u64,
        currency_type: u8,
    }

    struct DealRejected has copy, drop {
        deal_id: 0x2::object::ID,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct DealCancelled has copy, drop {
        deal_id: 0x2::object::ID,
        consumer: address,
        timestamp: u64,
    }

    public(friend) fun add_funds_to_escrow(arg0: &mut DataUnit, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrowed_funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.updated_at = 0;
    }

    public(friend) fun add_funds_to_escrow_usdc<T0>(arg0: &mut DataUnitUSDC<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.escrowed_funds, 0x2::coin::into_balance<T0>(arg1));
        arg0.updated_at = 0;
    }

    public fun cancel_deal(arg0: &mut DataUnit, arg1: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.consumer, 105);
        assert!(arg0.status == 0, 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::release_capacity(arg1, arg0.capacity_gb);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrowed_funds, 0x2::balance::value<0x2::sui::SUI>(&arg0.escrowed_funds), arg2), arg0.consumer);
        arg0.status = 5;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v0 = DealCancelled{
            deal_id   : 0x2::object::uid_to_inner(&arg0.id),
            consumer  : arg0.consumer,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<DealCancelled>(v0);
    }

    public fun cancel_deal_usdc<T0>(arg0: &mut DataUnitUSDC<T0>, arg1: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.consumer, 105);
        assert!(arg0.status == 0, 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::release_capacity(arg1, arg0.capacity_gb);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrowed_funds, 0x2::balance::value<T0>(&arg0.escrowed_funds), arg2), arg0.consumer);
        arg0.status = 5;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v0 = DealCancelled{
            deal_id   : 0x2::object::uid_to_inner(&arg0.id),
            consumer  : arg0.consumer,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<DealCancelled>(v0);
    }

    public fun complete_deal(arg0: &mut DataUnit, arg1: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v0 >= arg0.end_timestamp, 100);
        assert!(arg0.status == 0, 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::release_capacity(arg1, arg0.capacity_gb);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrowed_funds);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrowed_funds, v1, arg2), arg0.provider);
        arg0.status = 1;
        arg0.updated_at = v0;
        let v2 = DealCompleted{
            deal_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount_paid   : v1,
            currency_type : 0,
        };
        0x2::event::emit<DealCompleted>(v2);
    }

    public fun complete_deal_usdc<T0>(arg0: &mut DataUnitUSDC<T0>, arg1: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v0 >= arg0.end_timestamp, 100);
        assert!(arg0.status == 0, 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::release_capacity(arg1, arg0.capacity_gb);
        let v1 = 0x2::balance::value<T0>(&arg0.escrowed_funds);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrowed_funds, v1, arg2), arg0.provider);
        arg0.status = 1;
        arg0.updated_at = v0;
        let v2 = DealCompleted{
            deal_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount_paid   : v1,
            currency_type : 1,
        };
        0x2::event::emit<DealCompleted>(v2);
    }

    public fun create_deal(arg0: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v2 = 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::get_pricing(arg0);
        let v3 = arg2 * v2 * (arg3 as u64) * 1000 / 2592000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 102);
        assert!(0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::is_active(arg0), 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::reserve_capacity(arg0, arg2);
        let v4 = DataUnit{
            id                      : 0x2::object::new(arg5),
            consumer                : v0,
            provider                : 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::get_owner(arg0),
            provider_id             : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider>(arg0),
            capacity_gb             : arg2,
            duration_days           : arg3,
            price_per_gb_per_month  : v2,
            total_amount            : v3,
            escrowed_funds          : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            fb_deal_id              : 0x1::vector::empty<u8>(),
            start_timestamp         : v1,
            end_timestamp           : v1 + (arg3 as u64) * 24 * 60 * 60 * 1000,
            status                  : 0,
            currency_type           : 0,
            walrus_metadata_blob_id : arg4,
            qos_stats_id            : 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::qos::create_qos_stats(0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider>(arg0), v0, arg5),
            created_at              : v1,
            updated_at              : v1,
        };
        let v5 = DealCreated{
            deal_id       : 0x2::object::uid_to_inner(&v4.id),
            consumer      : v0,
            provider      : 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::get_owner(arg0),
            capacity_gb   : arg2,
            total_amount  : v3,
            duration_days : arg3,
            currency_type : 0,
        };
        0x2::event::emit<DealCreated>(v5);
        0x2::transfer::share_object<DataUnit>(v4);
    }

    public fun create_deal_usdc<T0>(arg0: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v2 = 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::get_pricing(arg0);
        let v3 = arg2 * v2 * (arg3 as u64) * 1000 / 2592000000;
        assert!(0x2::coin::value<T0>(&arg1) >= v3, 102);
        assert!(0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::is_active(arg0), 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::reserve_capacity(arg0, arg2);
        let v4 = DataUnitUSDC<T0>{
            id                      : 0x2::object::new(arg5),
            consumer                : v0,
            provider                : 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::get_owner(arg0),
            provider_id             : 0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider>(arg0),
            capacity_gb             : arg2,
            duration_days           : arg3,
            price_per_gb_per_month  : v2,
            total_amount            : v3,
            escrowed_funds          : 0x2::coin::into_balance<T0>(arg1),
            fb_deal_id              : 0x1::vector::empty<u8>(),
            start_timestamp         : v1,
            end_timestamp           : v1 + (arg3 as u64) * 24 * 60 * 60 * 1000,
            status                  : 0,
            currency_type           : 1,
            walrus_metadata_blob_id : arg4,
            qos_stats_id            : 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::qos::create_qos_stats(0x2::object::id<0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider>(arg0), v0, arg5),
            created_at              : v1,
            updated_at              : v1,
        };
        let v5 = DealCreated{
            deal_id       : 0x2::object::uid_to_inner(&v4.id),
            consumer      : v0,
            provider      : 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::get_owner(arg0),
            capacity_gb   : arg2,
            total_amount  : v3,
            duration_days : arg3,
            currency_type : 1,
        };
        0x2::event::emit<DealCreated>(v5);
        0x2::transfer::share_object<DataUnitUSDC<T0>>(v4);
    }

    public(friend) fun extend_duration(arg0: &mut DataUnit, arg1: u64) : u64 {
        arg0.end_timestamp = arg0.end_timestamp + (arg1 as u64) * 24 * 60 * 60 * 1000;
        arg0.duration_days = arg0.duration_days + arg1;
        arg0.end_timestamp
    }

    public(friend) fun extend_duration_usdc<T0>(arg0: &mut DataUnitUSDC<T0>, arg1: u64) : u64 {
        arg0.end_timestamp = arg0.end_timestamp + (arg1 as u64) * 24 * 60 * 60 * 1000;
        arg0.duration_days = arg0.duration_days + arg1;
        arg0.end_timestamp
    }

    public fun get_currency_type(arg0: &DataUnit) : u8 {
        arg0.currency_type
    }

    public fun get_currency_type_usdc<T0>(arg0: &DataUnitUSDC<T0>) : u8 {
        arg0.currency_type
    }

    public fun get_deal_details(arg0: &DataUnit) : (address, address, u64, u64, u64) {
        (arg0.consumer, arg0.provider, arg0.capacity_gb, arg0.price_per_gb_per_month, arg0.duration_days)
    }

    public fun get_deal_details_usdc<T0>(arg0: &DataUnitUSDC<T0>) : (address, address, u64, u64, u64) {
        (arg0.consumer, arg0.provider, arg0.capacity_gb, arg0.price_per_gb_per_month, arg0.duration_days)
    }

    public fun get_deal_info(arg0: &DataUnit) : (address, address, u64, u64, u8) {
        (arg0.consumer, arg0.provider, arg0.capacity_gb, arg0.total_amount, arg0.status)
    }

    public fun get_deal_info_usdc<T0>(arg0: &DataUnitUSDC<T0>) : (address, address, u64, u64, u8) {
        (arg0.consumer, arg0.provider, arg0.capacity_gb, arg0.total_amount, arg0.status)
    }

    public fun refund_deal(arg0: &mut DataUnit, arg1: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::release_capacity(arg1, arg0.capacity_gb);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrowed_funds);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrowed_funds, v0, arg2), arg0.consumer);
        arg0.status = 3;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = DealRefunded{
            deal_id       : 0x2::object::uid_to_inner(&arg0.id),
            refund_amount : v0,
            currency_type : 0,
        };
        0x2::event::emit<DealRefunded>(v1);
    }

    public fun refund_deal_usdc<T0>(arg0: &mut DataUnitUSDC<T0>, arg1: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::release_capacity(arg1, arg0.capacity_gb);
        let v0 = 0x2::balance::value<T0>(&arg0.escrowed_funds);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrowed_funds, v0, arg2), arg0.consumer);
        arg0.status = 3;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = DealRefunded{
            deal_id       : 0x2::object::uid_to_inner(&arg0.id),
            refund_amount : v0,
            currency_type : 1,
        };
        0x2::event::emit<DealRefunded>(v1);
    }

    public fun reject_deal(arg0: &mut DataUnit, arg1: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.provider, 105);
        assert!(arg0.status == 0, 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::release_capacity(arg1, arg0.capacity_gb);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrowed_funds, 0x2::balance::value<0x2::sui::SUI>(&arg0.escrowed_funds), arg3), arg0.consumer);
        arg0.status = 4;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = DealRejected{
            deal_id   : 0x2::object::uid_to_inner(&arg0.id),
            reason    : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<DealRejected>(v0);
    }

    public fun reject_deal_usdc<T0>(arg0: &mut DataUnitUSDC<T0>, arg1: &mut 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::Provider, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.provider, 105);
        assert!(arg0.status == 0, 100);
        0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider::release_capacity(arg1, arg0.capacity_gb);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrowed_funds, 0x2::balance::value<T0>(&arg0.escrowed_funds), arg3), arg0.consumer);
        arg0.status = 4;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = DealRejected{
            deal_id   : 0x2::object::uid_to_inner(&arg0.id),
            reason    : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<DealRejected>(v0);
    }

    // decompiled from Move bytecode v6
}

