module 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WriteCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchRecord has copy, drop, store {
        anchor_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        peg_sui: u64,
        creator: address,
        launched_at_ms: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        launches: 0x2::table::Table<0x2::object::ID, LaunchRecord>,
        creator_launches: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_launches: u64,
        launch_fee_mist: u64,
        fees_collected_mist: u64,
        treasury: 0x2::coin::Coin<0x2::sui::SUI>,
        is_paused: bool,
        total_peg_volume_sui: u64,
    }

    struct LaunchRegistered has copy, drop {
        launch_number: u64,
        anchor_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        peg_sui: u64,
        creator: address,
        launched_at_ms: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee_mist: u64,
        new_fee_mist: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount_mist: u64,
        recipient: address,
    }

    struct PauseToggled has copy, drop {
        is_paused: bool,
    }

    public fun creator_launch_count(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.creator_launches, arg1)) {
            0x1::vector::length<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.creator_launches, arg1))
        } else {
            0
        }
    }

    public fun fees_collected_mist(arg0: &Registry) : u64 {
        arg0.fees_collected_mist
    }

    public fun get_creator_launches(arg0: &Registry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.creator_launches, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.creator_launches, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_launch(arg0: &Registry, arg1: 0x2::object::ID) : LaunchRecord {
        assert!(0x2::table::contains<0x2::object::ID, LaunchRecord>(&arg0.launches, arg1), 103);
        *0x2::table::borrow<0x2::object::ID, LaunchRecord>(&arg0.launches, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Registry{
            id                   : 0x2::object::new(arg0),
            launches             : 0x2::table::new<0x2::object::ID, LaunchRecord>(arg0),
            creator_launches     : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_launches       : 0,
            launch_fee_mist      : 500000000,
            fees_collected_mist  : 0,
            treasury             : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            is_paused            : false,
            total_peg_volume_sui : 0,
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
        let v3 = WriteCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<WriteCap>(v3, v0);
    }

    public fun is_paused(arg0: &Registry) : bool {
        arg0.is_paused
    }

    public fun is_registered(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, LaunchRecord>(&arg0.launches, arg1)
    }

    public fun launch_fee_mist(arg0: &Registry) : u64 {
        arg0.launch_fee_mist
    }

    public fun record_anchor_id(arg0: &LaunchRecord) : 0x2::object::ID {
        arg0.anchor_id
    }

    public fun record_creator(arg0: &LaunchRecord) : address {
        arg0.creator
    }

    public fun record_launched_at(arg0: &LaunchRecord) : u64 {
        arg0.launched_at_ms
    }

    public fun record_peg_sui(arg0: &LaunchRecord) : u64 {
        arg0.peg_sui
    }

    public fun record_pool_id(arg0: &LaunchRecord) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun record_token_name(arg0: &LaunchRecord) : &0x1::string::String {
        &arg0.token_name
    }

    public fun record_token_symbol(arg0: &LaunchRecord) : &0x1::string::String {
        &arg0.token_symbol
    }

    public fun register(arg0: &WriteCap, arg1: &mut Registry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: address, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 101);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= arg1.launch_fee_mist, 102);
        assert!(!0x2::table::contains<0x2::object::ID, LaunchRecord>(&arg1.launches, arg2), 104);
        arg1.fees_collected_mist = arg1.fees_collected_mist + 0x2::coin::value<0x2::sui::SUI>(&arg9);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.treasury, arg9);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = LaunchRecord{
            anchor_id      : arg2,
            pool_id        : arg3,
            token_type     : arg4,
            token_name     : arg5,
            token_symbol   : arg6,
            peg_sui        : arg7,
            creator        : arg8,
            launched_at_ms : v0,
        };
        0x2::table::add<0x2::object::ID, LaunchRecord>(&mut arg1.launches, arg2, v1);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.creator_launches, arg8)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.creator_launches, arg8, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.creator_launches, arg8), arg2);
        arg1.total_launches = arg1.total_launches + 1;
        arg1.total_peg_volume_sui = arg1.total_peg_volume_sui + arg7;
        let v2 = LaunchRegistered{
            launch_number  : arg1.total_launches,
            anchor_id      : arg2,
            pool_id        : arg3,
            token_type     : arg4,
            token_name     : arg5,
            token_symbol   : arg6,
            peg_sui        : arg7,
            creator        : arg8,
            launched_at_ms : v0,
        };
        0x2::event::emit<LaunchRegistered>(v2);
    }

    public fun set_launch_fee(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        assert!(arg2 >= 100000000, 105);
        arg1.launch_fee_mist = arg2;
        let v0 = FeeUpdated{
            old_fee_mist : arg1.launch_fee_mist,
            new_fee_mist : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Registry, arg2: bool) {
        arg1.is_paused = arg2;
        let v0 = PauseToggled{is_paused: arg2};
        0x2::event::emit<PauseToggled>(v0);
    }

    public fun total_launches(arg0: &Registry) : u64 {
        arg0.total_launches
    }

    public fun total_peg_volume_sui(arg0: &Registry) : u64 {
        arg0.total_peg_volume_sui
    }

    public fun transfer_write_cap(arg0: WriteCap, arg1: address) {
        0x2::transfer::transfer<WriteCap>(arg0, arg1);
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1.treasury);
        assert!(v0 > 0, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.treasury, v0, arg3), arg2);
        let v1 = FeesWithdrawn{
            amount_mist : v0,
            recipient   : arg2,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    public fun withdraw_fees_partial(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 102);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1.treasury) >= arg2, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.treasury, arg2, arg4), arg3);
        let v0 = FeesWithdrawn{
            amount_mist : arg2,
            recipient   : arg3,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

