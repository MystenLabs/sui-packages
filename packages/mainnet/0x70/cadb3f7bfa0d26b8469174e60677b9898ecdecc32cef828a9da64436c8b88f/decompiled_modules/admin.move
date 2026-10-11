module 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun admin_withdraw<T0>(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::admin_withdraw<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create_account(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::share_account(0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::create(arg1, arg2));
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::share_vault<T0>(0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::create<T0>(arg1, arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun modify_vault_status<T0>(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: bool) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::modify_status<T0>(arg1, arg2);
    }

    public fun modify_vault_tag<T0>(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: vector<u8>) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::modify_tag<T0>(arg1, arg2);
    }

    public fun update_account_owner(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg2: address) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::modify_owner(arg1, arg2);
    }

    public fun update_account_recipient(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg2: address) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::modify_recipient(arg1, arg2);
    }

    public fun update_account_slot(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg2: vector<u8>) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::modify_slot(arg1, arg2);
    }

    public fun update_account_tag(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg2: vector<u8>) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::modify_tag(arg1, arg2);
    }

    public fun update_vault_slot<T0>(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: vector<u8>) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::modify_slot<T0>(arg1, arg2);
    }

    public fun update_vault_traders<T0>(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: vector<address>) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::modify_traders<T0>(arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::withdraw<T0>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

