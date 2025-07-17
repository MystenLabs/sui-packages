module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_reward_manager(arg0: &AdminCap, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: address) {
        abort 0
    }

    entry fun add_reward_reserves_to_pool<T0, T1, T2>(arg0: &AdminCap, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T2>) {
        abort 0
    }

    public fun add_seconds_to_reward_emission<T0, T1, T2>(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_pool_creation_fee<T0>(arg0: &ProtocolFeeCap, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_protocol_fee<T0, T1>(arg0: &ProtocolFeeCap, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun increase_observation_cardinality_next<T0, T1>(arg0: &AdminCap, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg2: u64) {
        abort 0
    }

    public entry fun initialize_pool_reward<T0, T1, T2>(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T2>, arg5: 0x1::string::String, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun remove_reward_manager(arg0: &AdminCap, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: address) {
        abort 0
    }

    public entry fun set_pool_creation_fee<T0>(arg0: &AdminCap, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun set_pool_manager<T0, T1>(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun transer_admin_cap(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: AdminCap, arg2: address) {
        abort 0
    }

    public entry fun transer_protocol_fee_cap(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: ProtocolFeeCap, arg2: address) {
        abort 0
    }

    public entry fun update_pool_pause_status<T0, T1>(arg0: &AdminCap, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: bool) {
        abort 0
    }

    public entry fun update_pool_reward_emission<T0, T1, T2>(arg0: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_protocol_fee_share<T0, T1>(arg0: &AdminCap, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg2: u64) {
        abort 0
    }

    public entry fun update_supported_version(arg0: &AdminCap, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

