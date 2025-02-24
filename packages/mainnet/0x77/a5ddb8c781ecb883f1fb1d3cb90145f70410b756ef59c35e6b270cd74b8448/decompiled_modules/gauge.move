module 0x6e3ae31a16362c563c0fef5293348d262646882a10c307f20f6be8577960f1ef::gauge {
    struct EventStakedIDs has copy, drop {
        ids: vector<0x2::object::ID>,
    }

    struct EventPositionInfo has copy, drop {
        info: 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::PositionInfo,
        earned: u64,
        pool_id: 0x2::object::ID,
    }

    struct EventPositionInfos has copy, drop {
        infos: vector<EventPositionInfo>,
    }

    public entry fun deposit_position<T0, T1, T2>(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config::DistributionConfig, arg2: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>, arg3: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg4: 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::Position, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::deposit_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdraw_position<T0, T1, T2>(arg0: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::withdraw_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun position_info<T0, T1, T2>(arg0: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter::Voter<T2>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>, arg2: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = EventPositionInfo{
            info    : *0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::borrow_position_info<T0, T1>(arg2, arg3),
            earned  : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::earned_by_position<T0, T1, T2>(arg1, arg2, arg3, arg4),
            pool_id : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::pool_id<T0, T1, T2>(arg1),
        };
        0x2::event::emit<EventPositionInfo>(v0);
    }

    public entry fun staked_ids<T0, T1, T2>(arg0: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>, arg1: address) {
        let v0 = EventStakedIDs{ids: 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::stakes<T0, T1, T2>(arg0, arg1)};
        0x2::event::emit<EventStakedIDs>(v0);
    }

    public entry fun user_staked_position_infos<T0, T1, T2>(arg0: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voter::Voter<T2>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::Gauge<T0, T1, T2>, arg2: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock) {
        let v0 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::stakes<T0, T1, T2>(arg1, arg3);
        let v1 = 0;
        let v2 = EventPositionInfos{infos: 0x1::vector::empty<EventPositionInfo>()};
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = EventPositionInfo{
                info    : *0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::borrow_position_info<T0, T1>(arg2, *0x1::vector::borrow<0x2::object::ID>(&v0, v1)),
                earned  : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::earned_by_position<T0, T1, T2>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(&v0, v1), arg4),
                pool_id : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::gauge::pool_id<T0, T1, T2>(arg1),
            };
            0x1::vector::push_back<EventPositionInfo>(&mut v2.infos, v3);
            v1 = v1 + 1;
        };
        0x2::event::emit<EventPositionInfos>(v2);
    }

    // decompiled from Move bytecode v6
}

