module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption_registry {
    struct RedemptionRegistry has store, key {
        id: 0x2::object::UID,
        processed_redemptions: 0x2::table::Table<0x1::string::String, bool>,
        total_burned: u64,
        redemption_count: u64,
    }

    public(friend) fun borrow_processed_redemptions(arg0: &mut RedemptionRegistry) : &mut 0x2::table::Table<0x1::string::String, bool> {
        &mut arg0.processed_redemptions
    }

    public(friend) fun get_processed_redemptions(arg0: &RedemptionRegistry) : &0x2::table::Table<0x1::string::String, bool> {
        &arg0.processed_redemptions
    }

    public(friend) fun get_redemption_count(arg0: &RedemptionRegistry) : u64 {
        arg0.redemption_count
    }

    public(friend) fun get_total_burned(arg0: &RedemptionRegistry) : u64 {
        arg0.total_burned
    }

    public(friend) fun increment_redemption_count_by(arg0: &mut RedemptionRegistry, arg1: u64) {
        arg0.redemption_count = arg0.redemption_count + arg1;
    }

    public(friend) fun increment_total_burned_by(arg0: &mut RedemptionRegistry, arg1: u64) {
        arg0.total_burned = arg0.total_burned + arg1;
    }

    public(friend) fun new_redemption_registry(arg0: &mut 0x2::tx_context::TxContext) : RedemptionRegistry {
        RedemptionRegistry{
            id                    : 0x2::object::new(arg0),
            processed_redemptions : 0x2::table::new<0x1::string::String, bool>(arg0),
            total_burned          : 0,
            redemption_count      : 0,
        }
    }

    // decompiled from Move bytecode v6
}

