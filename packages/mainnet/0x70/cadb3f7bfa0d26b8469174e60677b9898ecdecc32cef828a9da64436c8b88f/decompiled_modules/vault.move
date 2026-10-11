module 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        tag: vector<u8>,
        balance: 0x2::balance::Balance<T0>,
        enabled: bool,
        traders: vector<address>,
        slot: vector<u8>,
    }

    public(friend) fun admin_withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::zero_amount());
        assert!(vault_balance<T0>(arg0) >= arg1, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::insufficient_vault_balance());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    fun check_vault<T0>(arg0: &Vault<T0>) {
        assert!(arg0.enabled, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::vault_is_disabled());
    }

    public(friend) fun create<T0>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id      : 0x2::object::new(arg1),
            tag     : arg0,
            balance : 0x2::balance::zero<T0>(),
            enabled : true,
            traders : vector[],
            slot    : b"",
        }
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::zero_amount());
        check_vault<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1))
    }

    public(friend) fun modify_slot<T0>(arg0: &mut Vault<T0>, arg1: vector<u8>) {
        arg0.slot = arg1;
    }

    public(friend) fun modify_status<T0>(arg0: &mut Vault<T0>, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun modify_tag<T0>(arg0: &mut Vault<T0>, arg1: vector<u8>) {
        arg0.tag = arg1;
    }

    public(friend) fun modify_traders<T0>(arg0: &mut Vault<T0>, arg1: vector<address>) {
        arg0.traders = arg1;
    }

    public(friend) fun share_vault<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public fun vault_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun vault_enabled<T0>(arg0: &Vault<T0>) : bool {
        arg0.enabled
    }

    public fun vault_id<T0>(arg0: &Vault<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun vault_slot<T0>(arg0: &Vault<T0>) : vector<u8> {
        arg0.slot
    }

    public fun vault_tag<T0>(arg0: &Vault<T0>) : vector<u8> {
        arg0.tag
    }

    public fun vault_traders<T0>(arg0: &Vault<T0>) : vector<address> {
        arg0.traders
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::zero_amount());
        check_vault<T0>(arg0);
        assert!(vault_balance<T0>(arg0) >= arg1, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::insufficient_vault_balance());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

