module 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats {
    struct NewLiquidStatsEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct SuidoubleLiquidStats has key {
        id: 0x2::object::UID,
        pool_ids: 0x2::table::Table<0x2::object::ID, SuidoubleLiquidValidatorInfo>,
        metadata: vector<u8>,
    }

    struct SuidoubleLiquidValidatorInfo has drop, store {
        address: address,
        metadata: vector<u8>,
    }

    public(friend) fun default(arg0: &mut 0x2::tx_context::TxContext) : SuidoubleLiquidStats {
        SuidoubleLiquidStats{
            id       : 0x2::object::new(arg0),
            pool_ids : 0x2::table::new<0x2::object::ID, SuidoubleLiquidValidatorInfo>(arg0),
            metadata : 0x1::vector::empty<u8>(),
        }
    }

    public(friend) fun default_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = default(arg0);
        let v1 = NewLiquidStatsEvent{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<NewLiquidStatsEvent>(v1);
        0x2::transfer::share_object<SuidoubleLiquidStats>(v0);
    }

    public(friend) fun get_and_consume_metadata_next_validator(arg0: &mut SuidoubleLiquidStats) : 0x1::option::Option<address> {
        let v0 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_metadata::get_metadata_address(&arg0.metadata, 0);
        if (0x1::option::is_some<address>(&v0)) {
            0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_metadata::remove_metadata(&mut arg0.metadata, 0);
            return 0x1::option::some<address>(0x1::option::destroy_some<address>(v0))
        };
        0x1::option::none<address>()
    }

    public(friend) fun set_metadata_next_validator(arg0: &mut SuidoubleLiquidStats, arg1: address) : bool {
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_metadata::set_metadata_address(&mut arg0.metadata, 0, arg1)
    }

    public(friend) fun store_address(arg0: &mut SuidoubleLiquidStats, arg1: 0x2::object::ID, arg2: address) {
        if (0x2::table::contains<0x2::object::ID, SuidoubleLiquidValidatorInfo>(&arg0.pool_ids, arg1)) {
            0x2::table::borrow_mut<0x2::object::ID, SuidoubleLiquidValidatorInfo>(&mut arg0.pool_ids, arg1).address = arg2;
        } else {
            let v0 = SuidoubleLiquidValidatorInfo{
                address  : arg2,
                metadata : 0x1::vector::empty<u8>(),
            };
            0x2::table::add<0x2::object::ID, SuidoubleLiquidValidatorInfo>(&mut arg0.pool_ids, arg1, v0);
        };
    }

    public(friend) fun validator_address_by_pool_id(arg0: &mut SuidoubleLiquidStats, arg1: 0x2::object::ID) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x2::object::ID, SuidoubleLiquidValidatorInfo>(&arg0.pool_ids, arg1)) {
            return 0x1::option::some<address>(0x2::table::borrow<0x2::object::ID, SuidoubleLiquidValidatorInfo>(&arg0.pool_ids, arg1).address)
        };
        0x1::option::none<address>()
    }

    // decompiled from Move bytecode v6
}

