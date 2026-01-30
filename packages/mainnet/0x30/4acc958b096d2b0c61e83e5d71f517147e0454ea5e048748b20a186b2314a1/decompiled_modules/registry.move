module 0x304acc958b096d2b0c61e83e5d71f517147e0454ea5e048748b20a186b2314a1::registry {
    struct AccountCapRegistry has store, key {
        id: 0x2::object::UID,
        account_caps: 0x2::table::Table<u64, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::account::AccountCap>,
    }

    public fun get_account_cap(arg0: &AccountCapRegistry) : &0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::account::AccountCap {
        0x2::table::borrow<u64, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::account::AccountCap>(&arg0.account_caps, 0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountCapRegistry{
            id           : 0x2::object::new(arg0),
            account_caps : 0x2::table::new<u64, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::account::AccountCap>(arg0),
        };
        0x2::table::add<u64, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::account::AccountCap>(&mut v0.account_caps, 0, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::lending::create_account(arg0));
        0x2::transfer::share_object<AccountCapRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

