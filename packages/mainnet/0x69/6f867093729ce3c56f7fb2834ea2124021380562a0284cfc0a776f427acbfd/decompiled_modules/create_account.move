module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::create_account {
    struct AccountCreatedEvent has copy, drop, store {
        account_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
        creator_address: address,
    }

    public fun create_account<T0>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg2);
        create_account_int<T0>(arg0, arg1, arg3)
    }

    entry fun create_account_entry<T0>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_account<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap>(v0, 0x2::tx_context::sender(arg3));
    }

    fun create_account_int<T0>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap {
        assert!(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::mint_fee<T0>(arg0) == 0x2::coin::value<0x2::sui::SUI>(&arg1), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_mint_fee());
        let (v0, v1, v2, v3) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::new<T0>(arg2);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::add<T0>(arg0, v1, v3);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::add_mint_fee<T0>(arg0, arg1);
        let v4 = AccountCreatedEvent{
            account_id      : v3,
            account_cap_id  : v2,
            creator_address : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AccountCreatedEvent>(v4);
        v0
    }

    // decompiled from Move bytecode v6
}

