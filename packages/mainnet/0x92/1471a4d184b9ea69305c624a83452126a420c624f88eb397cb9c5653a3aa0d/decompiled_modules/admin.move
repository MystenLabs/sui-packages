module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManageCap has key {
        id: 0x2::object::UID,
        whitelisted_addresses: vector<address>,
    }

    public fun add_swap_route<T0, T1, T2, T3: store, T4>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::add_swap_route<T0, T1, T2, T4>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config_mut<T0, T1, T2, T3>(arg1), arg2);
    }

    public fun add_whitelisted_manager(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        if (!0x1::vector::contains<address>(&arg1.whitelisted_addresses, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AdminCap>(v0);
        let v1 = ManageCap{
            id                    : 0x2::object::new(arg0),
            whitelisted_addresses : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<ManageCap>(v1);
    }

    public fun is_whitelisted_manager(arg0: &ManageCap, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public fun remove_swap_route<T0, T1, T2, T3: store, T4>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::remove_swap_route<T0, T1, T2, T4>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config_mut<T0, T1, T2, T3>(arg1));
    }

    public fun remove_whitelisted_manager(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.whitelisted_addresses, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
        };
    }

    public fun set_deposit_limit<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::set_deposit_limit<T0, T1, T2>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config_mut<T0, T1, T2, T3>(arg1), arg2);
    }

    public fun set_deposits_enabled<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: bool) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::set_deposits_enabled<T0, T1, T2>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config_mut<T0, T1, T2, T3>(arg1), arg2);
    }

    public fun set_performance_fees<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::set_performance_fees<T0, T1, T2>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config_mut<T0, T1, T2, T3>(arg1), arg2);
    }

    public fun set_withdrawal_fees<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::set_withdrawal_fees<T0, T1, T2>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config_mut<T0, T1, T2, T3>(arg1), arg2);
    }

    public fun withdraw_performance_fees<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::withdraw_performance_fees<T0, T1, T2>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config_mut<T0, T1, T2, T3>(arg1), arg2)
    }

    public fun withdraw_withdrawal_fees<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::withdraw_withdrawal_fees<T0, T1, T2>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config_mut<T0, T1, T2, T3>(arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

