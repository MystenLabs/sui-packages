module 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan {
    struct Plan has copy, drop, store {
        plan_id: u64,
        subscription_amount: u64,
        subscription_interval: u64,
        next_execution_time: u64,
        execution_count: u64,
        execution_limit: u64,
        average_price: u64,
        total_purchased_amount: u64,
        creation_time: u64,
        owner: address,
        receiver: address,
        source_asset: 0x1::type_name::TypeName,
        target_asset: 0x1::type_name::TypeName,
        paused: bool,
    }

    public fun average_price(arg0: &Plan) : u64 {
        arg0.average_price
    }

    public fun clone(arg0: &Plan) : Plan {
        Plan{
            plan_id                : arg0.plan_id,
            subscription_amount    : arg0.subscription_amount,
            subscription_interval  : arg0.subscription_interval,
            next_execution_time    : arg0.next_execution_time,
            execution_count        : arg0.execution_count,
            execution_limit        : arg0.execution_limit,
            average_price          : arg0.average_price,
            total_purchased_amount : arg0.total_purchased_amount,
            creation_time          : arg0.creation_time,
            owner                  : arg0.owner,
            receiver               : arg0.receiver,
            source_asset           : arg0.source_asset,
            target_asset           : arg0.target_asset,
            paused                 : arg0.paused,
        }
    }

    public fun creation_time(arg0: &Plan) : u64 {
        arg0.creation_time
    }

    public(friend) fun destroy(arg0: Plan) {
        let Plan {
            plan_id                : _,
            subscription_amount    : _,
            subscription_interval  : _,
            next_execution_time    : _,
            execution_count        : _,
            execution_limit        : _,
            average_price          : _,
            total_purchased_amount : _,
            creation_time          : _,
            owner                  : _,
            receiver               : _,
            source_asset           : _,
            target_asset           : _,
            paused                 : _,
        } = arg0;
    }

    public(friend) fun execute(arg0: &mut Plan, arg1: u64) {
        arg0.execution_count = arg0.execution_count + 1;
        arg0.next_execution_time = arg0.next_execution_time + arg0.subscription_interval;
        arg0.total_purchased_amount = arg0.total_purchased_amount + arg1;
        arg0.average_price = 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::math::calculate_price(arg0.execution_count * arg0.subscription_amount, arg0.total_purchased_amount);
    }

    public fun execution_count(arg0: &Plan) : u64 {
        arg0.execution_count
    }

    public fun execution_limit(arg0: &Plan) : u64 {
        arg0.execution_limit
    }

    public fun is_executable(arg0: &Plan, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.next_execution_time
    }

    public fun is_paused(arg0: &Plan) : bool {
        arg0.paused
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: address, arg7: u64) : Plan {
        Plan{
            plan_id                : arg0,
            subscription_amount    : arg1,
            subscription_interval  : arg2,
            next_execution_time    : arg3,
            execution_count        : 0,
            execution_limit        : arg4,
            average_price          : 0,
            total_purchased_amount : 0,
            creation_time          : arg7,
            owner                  : arg5,
            receiver               : arg6,
            source_asset           : 0x1::type_name::get<T0>(),
            target_asset           : 0x1::type_name::get<T1>(),
            paused                 : false,
        }
    }

    public fun next_execution_time(arg0: &Plan) : u64 {
        arg0.next_execution_time
    }

    public fun owner(arg0: &Plan) : address {
        arg0.owner
    }

    public(friend) fun pause(arg0: &mut Plan) {
        arg0.paused = true;
    }

    public fun plan_id(arg0: &Plan) : u64 {
        arg0.plan_id
    }

    public fun receiver(arg0: &Plan) : address {
        arg0.receiver
    }

    public fun source_asset(arg0: &Plan) : &0x1::type_name::TypeName {
        &arg0.source_asset
    }

    public fun subscription_amount(arg0: &Plan) : u64 {
        arg0.subscription_amount
    }

    public fun subscription_interval(arg0: &Plan) : u64 {
        arg0.subscription_interval
    }

    public fun target_asset(arg0: &Plan) : &0x1::type_name::TypeName {
        &arg0.target_asset
    }

    public fun total_purchased_amount(arg0: &Plan) : u64 {
        arg0.total_purchased_amount
    }

    public(friend) fun unpause(arg0: &mut Plan) {
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

