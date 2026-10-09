module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config {
    public(friend) fun bitcoin_chain_id(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : address {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_address(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::get(arg0, b"bitcoin_chain_id"))
    }

    public(friend) fun bitcoin_confirmation_threshold(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::get(arg0, b"bitcoin_confirmation_threshold"))
    }

    public(friend) fun bitcoin_deposit_minimum(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        0x1::u64::max(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::get(arg0, b"bitcoin_deposit_minimum")), 546)
    }

    public(friend) fun bitcoin_deposit_time_delay_ms(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::get(arg0, b"bitcoin_deposit_time_delay_ms"))
    }

    public(friend) fun bitcoin_withdrawal_minimum(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        0x1::u64::max(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::get(arg0, b"bitcoin_withdrawal_minimum")), 546 + 1)
    }

    public(friend) fun dust_relay_min_value() : u64 {
        546
    }

    public(friend) fun init_defaults(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_deposit_time_delay_ms", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(600000));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_deposit_minimum", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(30000));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_withdrawal_minimum", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(30000));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_confirmation_threshold", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(6));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"withdrawal_cancellation_cooldown_ms", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(3600000));
    }

    public(friend) fun is_governable_key(arg0: &0x1::string::String) : bool {
        let v0 = b"bitcoin_chain_id";
        0x1::string::as_bytes(arg0) != &v0
    }

    public(friend) fun set_bitcoin_chain_id(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg1: address) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_chain_id", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_address(arg1));
    }

    public(friend) fun set_bitcoin_confirmation_threshold(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg1: u64) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_confirmation_threshold", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(arg1));
    }

    public(friend) fun set_bitcoin_deposit_minimum(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg1: u64) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_deposit_minimum", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(arg1));
    }

    public(friend) fun set_bitcoin_deposit_time_delay_ms(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg1: u64) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_deposit_time_delay_ms", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(arg1));
    }

    public(friend) fun set_bitcoin_withdrawal_minimum(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg1: u64) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"bitcoin_withdrawal_minimum", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(arg1));
    }

    public(friend) fun set_withdrawal_cancellation_cooldown_ms(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg1: u64) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"withdrawal_cancellation_cooldown_ms", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(arg1));
    }

    public(friend) fun withdrawal_cancellation_cooldown_ms(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::get(arg0, b"withdrawal_cancellation_cooldown_ms"))
    }

    public(friend) fun worst_case_network_fee(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        bitcoin_withdrawal_minimum(arg0) - 546
    }

    // decompiled from Move bytecode v7
}

