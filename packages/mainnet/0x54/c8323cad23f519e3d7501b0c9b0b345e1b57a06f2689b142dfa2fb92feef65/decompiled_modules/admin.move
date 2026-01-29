module 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun admin_withdraw<T0>(arg0: &AdminCap, arg1: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::withdraw<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create_trader_account(arg0: &AdminCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::share_account(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::create(arg1, arg2, arg3));
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::share_vault<T0>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::create<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun update_trader_owner(arg0: &AdminCap, arg1: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg2: address) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::update_owner(arg1, arg2);
    }

    public fun update_trader_profit(arg0: &AdminCap, arg1: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg2: address) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::update_profit_address(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

