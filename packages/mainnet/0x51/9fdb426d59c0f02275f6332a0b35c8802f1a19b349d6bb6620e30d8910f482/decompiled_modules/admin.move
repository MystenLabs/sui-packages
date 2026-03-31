module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun create_trader_account(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::share_account(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::create(arg1, arg2));
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::share_vault<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::create<T0>(arg1, arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun update_trader_owner(arg0: &AdminCap, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg2: address) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::update_owner(arg1, arg2);
    }

    public fun update_trader_profit(arg0: &AdminCap, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg2: address) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::update_profit_address(arg1, arg2);
    }

    public fun update_trader_tag(arg0: &AdminCap, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg2: vector<u8>) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::update_profit_tag(arg1, arg2);
    }

    public fun update_vault_status<T0>(arg0: &AdminCap, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg2: bool) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::update_status<T0>(arg1, arg2);
    }

    public fun update_vault_tag<T0>(arg0: &AdminCap, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg2: vector<u8>) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::update_tag<T0>(arg1, arg2);
    }

    public fun vault2address<T0>(arg0: &AdminCap, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg2: address, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg3)
        };
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::transfer_to_address<T0>(arg1, arg2, v0, arg5);
    }

    public fun vault2vault<T0>(arg0: &AdminCap, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg2: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg3: u64, arg4: bool) {
        let v0 = if (arg4) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg3)
        };
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::transfer_to_vault<T0>(arg1, arg2, v0);
    }

    public fun withdraw_to_admin<T0>(arg0: &AdminCap, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::transfer_to_address<T0>(arg1, 0x2::tx_context::sender(arg3), 0x1::option::some<u64>(arg2), arg3);
    }

    // decompiled from Move bytecode v6
}

