module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManageCap has key {
        id: 0x2::object::UID,
        whitelisted_addresses: vector<address>,
    }

    public fun add_swap_route<T0, T1, T2, T3: store, T4>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        abort 1000
    }

    public fun add_whitelisted_manager(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        abort 1000
    }

    public fun destroy_legacy_admin_cap(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: AdminCap) {
        let AdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
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
        abort 1000
    }

    public fun remove_whitelisted_manager(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        abort 1000
    }

    public fun set_deposit_limit<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        abort 1000
    }

    public fun set_deposits_enabled<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: bool) {
        abort 1000
    }

    public fun set_performance_fees<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        abort 1000
    }

    public fun set_withdrawal_fees<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        abort 1000
    }

    public fun withdraw_performance_fees<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) : 0x2::balance::Balance<T0> {
        abort 1000
    }

    public fun withdraw_withdrawal_fees<T0, T1, T2, T3: store>(arg0: &AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: u64) : 0x2::balance::Balance<T0> {
        abort 1000
    }

    // decompiled from Move bytecode v7
}

