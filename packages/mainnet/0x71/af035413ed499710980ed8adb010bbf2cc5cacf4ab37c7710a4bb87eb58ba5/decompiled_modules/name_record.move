module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record {
    struct NameRecord has copy, drop, store {
        nft_id: 0x2::object::ID,
        expiration_timestamp_ms: u64,
        target_address: 0x1::option::Option<address>,
        data: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun data(arg0: &NameRecord) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.data
    }

    public fun expiration_timestamp_ms(arg0: &NameRecord) : u64 {
        arg0.expiration_timestamp_ms
    }

    public fun has_expired(arg0: &NameRecord, arg1: &0x2::clock::Clock) : bool {
        arg0.expiration_timestamp_ms < 0x2::clock::timestamp_ms(arg1)
    }

    public fun has_expired_past_grace_period(arg0: &NameRecord, arg1: &0x2::clock::Clock) : bool {
        arg0.expiration_timestamp_ms + 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::grace_period_ms() < 0x2::clock::timestamp_ms(arg1)
    }

    public fun is_leaf_record(arg0: &NameRecord) : bool {
        arg0.expiration_timestamp_ms == 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::leaf_expiration_timestamp()
    }

    public fun new(arg0: 0x2::object::ID, arg1: u64) : NameRecord {
        NameRecord{
            nft_id                  : arg0,
            expiration_timestamp_ms : arg1,
            target_address          : 0x1::option::none<address>(),
            data                    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun new_leaf(arg0: 0x2::object::ID, arg1: 0x1::option::Option<address>) : NameRecord {
        NameRecord{
            nft_id                  : arg0,
            expiration_timestamp_ms : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::leaf_expiration_timestamp(),
            target_address          : arg1,
            data                    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun nft_id(arg0: &NameRecord) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun set_data(arg0: &mut NameRecord, arg1: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        arg0.data = arg1;
    }

    public fun set_expiration_timestamp_ms(arg0: &mut NameRecord, arg1: u64) {
        arg0.expiration_timestamp_ms = arg1;
    }

    public fun set_target_address(arg0: &mut NameRecord, arg1: 0x1::option::Option<address>) {
        arg0.target_address = arg1;
    }

    public fun target_address(arg0: &NameRecord) : 0x1::option::Option<address> {
        arg0.target_address
    }

    // decompiled from Move bytecode v6
}

