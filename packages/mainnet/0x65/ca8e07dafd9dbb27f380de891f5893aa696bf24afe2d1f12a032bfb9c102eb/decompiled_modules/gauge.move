module 0xf899bbc12e73e254bcb4ab3e3eb886a4ca5a65022402c312e07f8ad3480bc185::gauge {
    struct EventStakedIDs has copy, drop {
        ids: vector<0x2::object::ID>,
    }

    struct EventPositionInfo has copy, drop {
        info: 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::PositionInfo,
        earned: u64,
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct EventPositionInfos has copy, drop {
        infos: vector<EventPositionInfo>,
    }

    public entry fun deposit_position<T0, T1, T2>(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg2: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>, arg3: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg4: 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::Position, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::deposit_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun position_info<T0, T1, T2>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T2>, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>, arg2: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = EventPositionInfo{
            info    : *0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::borrow_position_info<T0, T1>(arg2, arg3),
            earned  : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::earned_by_position<T0, T1, T2>(arg1, arg2, arg3, arg4),
            pool_id : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::pool_id<T0, T1, T2>(arg1),
            name    : 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::name(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::position_info<T0, T1, T2>(arg1, arg3)),
        };
        0x2::event::emit<EventPositionInfo>(v0);
    }

    public entry fun withdraw_position<T0, T1, T2>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::withdraw_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun get_reward_by_position<T0, T1, T2>(arg0: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::get_position_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun staked_ids<T0, T1, T2>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>, arg1: address) {
        let v0 = EventStakedIDs{ids: 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::stakes<T0, T1, T2>(arg0, arg1)};
        0x2::event::emit<EventStakedIDs>(v0);
    }

    public entry fun user_staked_position_infos<T0, T1, T2>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T2>, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::Gauge<T0, T1, T2>, arg2: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock) {
        let v0 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::stakes<T0, T1, T2>(arg1, arg3);
        let v1 = 0;
        let v2 = EventPositionInfos{infos: 0x1::vector::empty<EventPositionInfo>()};
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = EventPositionInfo{
                info    : *0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::borrow_position_info<T0, T1>(arg2, *0x1::vector::borrow<0x2::object::ID>(&v0, v1)),
                earned  : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::earned_by_position<T0, T1, T2>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(&v0, v1), arg4),
                pool_id : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::pool_id<T0, T1, T2>(arg1),
                name    : 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::name(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::gauge::position_info<T0, T1, T2>(arg1, *0x1::vector::borrow<0x2::object::ID>(&v0, v1))),
            };
            0x1::vector::push_back<EventPositionInfo>(&mut v2.infos, v3);
            v1 = v1 + 1;
        };
        0x2::event::emit<EventPositionInfos>(v2);
    }

    // decompiled from Move bytecode v6
}

