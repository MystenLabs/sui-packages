module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store {
    struct ACCOUNT_STORE has drop {
        dummy_field: bool,
    }

    struct AccountStore<phantom T0> has key {
        id: 0x2::object::UID,
        accounts: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>,
    }

    public fun borrow<T0>(arg0: &AccountStore<T0>, arg1: 0x2::object::ID) : &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0> {
        0x2::linked_table::borrow<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>(&arg0.accounts, arg1)
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut AccountStore<T0>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap) : &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0> {
        0x2::linked_table::borrow_mut<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>(&mut arg0.accounts, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::access_to(arg1))
    }

    public(friend) fun add<T0>(arg0: &mut AccountStore<T0>, arg1: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>, arg2: 0x2::object::ID) {
        0x2::linked_table::push_back<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>(&mut arg0.accounts, arg2, arg1);
    }

    public fun account_info<T0, T1>(arg0: &AccountStore<T1>, arg1: 0x2::object::ID) : (u64, u64, u64, u64, u64, u64, u64) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_info<T0, T1>(borrow<T1>(arg0, arg1))
    }

    public fun last_funding_deduction_timestamp<T0, T1>(arg0: &AccountStore<T1>, arg1: 0x2::object::ID) : u64 {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::last_funding_deduction_timestamp<T0, T1>(borrow<T1>(arg0, arg1))
    }

    public fun liabilities<T0, T1>(arg0: &AccountStore<T1>, arg1: 0x2::object::ID) : (u64, u64) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liabilities<T0, T1>(borrow<T1>(arg0, arg1))
    }

    public fun limit_order_notional_ask<T0, T1>(arg0: &AccountStore<T1>, arg1: 0x2::object::ID) : u64 {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::limit_order_notional_ask<T0, T1>(borrow<T1>(arg0, arg1))
    }

    public fun limit_order_notional_bid<T0, T1>(arg0: &AccountStore<T1>, arg1: 0x2::object::ID) : u64 {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::limit_order_notional_bid<T0, T1>(borrow<T1>(arg0, arg1))
    }

    public fun pnl_info<T0, T1>(arg0: &AccountStore<T1>, arg1: 0x2::object::ID) : (u64, bool) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::pnl_info<T0, T1>(borrow<T1>(arg0, arg1))
    }

    public fun total_deposits<T0, T1>(arg0: &AccountStore<T1>, arg1: 0x2::object::ID) : u64 {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::total_deposits<T0, T1>(borrow<T1>(arg0, arg1))
    }

    public fun total_withdrawals<T0, T1>(arg0: &AccountStore<T1>, arg1: 0x2::object::ID) : u64 {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::total_withdrawals<T0, T1>(borrow<T1>(arg0, arg1))
    }

    public(friend) fun add_mint_fee<T0>(arg0: &mut AccountStore<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"collected_fee"), arg1);
    }

    public fun batch_get_ids<T0>(arg0: &AccountStore<T0>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            0x1::option::destroy_some<0x2::object::ID>(arg1)
        } else {
            0x1::option::destroy_some<0x2::object::ID>(*0x2::linked_table::front<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>(&arg0.accounts))
        };
        let v2 = v1;
        0x1::vector::push_back<0x2::object::ID>(&mut v0, v1);
        let v3 = 1;
        while (0x1::option::is_some<0x2::object::ID>(0x2::linked_table::next<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>(&arg0.accounts, v2)) && v3 < arg2) {
            let v4 = 0x1::option::destroy_some<0x2::object::ID>(*0x2::linked_table::next<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>(&arg0.accounts, v2));
            v2 = v4;
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v4);
            v3 = v3 + 1;
        };
        v0
    }

    public(friend) fun friend_borrow<T0>(arg0: &mut AccountStore<T0>, arg1: 0x2::object::ID) : &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0> {
        0x2::linked_table::borrow_mut<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>(&mut arg0.accounts, arg1)
    }

    fun init(arg0: ACCOUNT_STORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ACCOUNT_STORE>(arg0, arg1);
    }

    public fun init_store<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<ACCOUNT_STORE>(arg0), 0);
        let v0 = AccountStore<T0>{
            id       : 0x2::object::new(arg1),
            accounts : 0x2::linked_table::new<0x2::object::ID, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T0>>(arg1),
        };
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v0.id, b"mint_fee", 1000000000);
        0x2::dynamic_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.id, b"collected_fee", 0x2::coin::zero<0x2::sui::SUI>(arg1));
        0x2::transfer::share_object<AccountStore<T0>>(v0);
    }

    public fun mint_fee<T0>(arg0: &AccountStore<T0>) : u64 {
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"mint_fee")
    }

    public(friend) fun update_mint_fee<T0>(arg0: &mut AccountStore<T0>, arg1: u64) {
        *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"mint_fee") = arg1;
    }

    public(friend) fun withdraw_mint_fee<T0>(arg0: &mut AccountStore<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"collected_fee"), arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

