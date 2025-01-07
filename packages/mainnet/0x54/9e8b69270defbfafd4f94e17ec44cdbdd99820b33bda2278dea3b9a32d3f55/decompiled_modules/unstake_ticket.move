module 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket {
    struct TicketMintedEvent has copy, drop {
        id: 0x2::object::ID,
        value: u64,
        unlock_epoch: u64,
        unstake_fee: u64,
    }

    struct TicketBurnedEvent has copy, drop {
        id: 0x2::object::ID,
        value: u64,
        epoch: u64,
        unstake_fee: u64,
    }

    struct UnstakeTicket has key {
        id: 0x2::object::UID,
        unlock_epoch: u64,
        value: u64,
        unstake_fee: u64,
    }

    struct Metadata has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: u64,
        max_history_value: 0x2::table::Table<u64, u64>,
    }

    public(friend) fun transfer(arg0: UnstakeTicket, arg1: address) {
        0x2::transfer::transfer<UnstakeTicket>(arg0, arg1);
    }

    fun add_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (0x2::table::contains<u64, u64>(&arg0.max_history_value, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.max_history_value, v0);
            *v1 = *v1 + arg1;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.max_history_value, v0, arg1);
        };
    }

    public(friend) fun create_metadata(arg0: &mut 0x2::tx_context::TxContext) : Metadata {
        Metadata{
            id                : 0x2::object::new(arg0),
            version           : 1,
            total_supply      : 0,
            max_history_value : 0x2::table::new<u64, u64>(arg0),
        }
    }

    public(friend) fun get_max_supply_for_2epochs(arg0: &Metadata, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch(arg1);
        let v1 = 0;
        if (0x2::table::contains<u64, u64>(&arg0.max_history_value, v0)) {
            v1 = *0x2::table::borrow<u64, u64>(&arg0.max_history_value, v0);
        };
        if (v0 > 0 && 0x2::table::contains<u64, u64>(&arg0.max_history_value, v0 - 1)) {
            v1 = v1 + *0x2::table::borrow<u64, u64>(&arg0.max_history_value, v0 - 1);
        };
        v1
    }

    public fun get_total_supply(arg0: &Metadata) : u64 {
        arg0.total_supply
    }

    public fun get_unlock_epoch(arg0: &UnstakeTicket) : u64 {
        arg0.unlock_epoch
    }

    public fun get_unstake_fee(arg0: &UnstakeTicket) : u64 {
        arg0.unstake_fee
    }

    public fun get_value(arg0: &UnstakeTicket) : u64 {
        arg0.value
    }

    public fun is_unlocked(arg0: &UnstakeTicket, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) >= arg0.unlock_epoch
    }

    public(friend) fun unwrap_unstake_ticket(arg0: &mut Metadata, arg1: UnstakeTicket, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        let UnstakeTicket {
            id           : v0,
            unlock_epoch : _,
            value        : v2,
            unstake_fee  : v3,
        } = arg1;
        let v4 = v0;
        arg0.total_supply = arg0.total_supply - v2;
        let v5 = TicketBurnedEvent{
            id          : 0x2::object::uid_to_inner(&v4),
            value       : v2,
            epoch       : 0x2::tx_context::epoch(arg2),
            unstake_fee : v3,
        };
        0x2::event::emit<TicketBurnedEvent>(v5);
        0x2::object::delete(v4);
        (v2, v3)
    }

    public(friend) fun wrap_unstake_ticket(arg0: &mut Metadata, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : UnstakeTicket {
        add_to_epoch(arg0, arg1, arg4);
        arg0.total_supply = arg0.total_supply + arg1;
        let v0 = UnstakeTicket{
            id           : 0x2::object::new(arg4),
            unlock_epoch : arg3,
            value        : arg1,
            unstake_fee  : arg2,
        };
        let v1 = TicketMintedEvent{
            id           : 0x2::object::uid_to_inner(&v0.id),
            value        : v0.value,
            unlock_epoch : v0.unlock_epoch,
            unstake_fee  : v0.unstake_fee,
        };
        0x2::event::emit<TicketMintedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

