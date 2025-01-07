module 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account {
    struct Account has store, key {
        id: 0x2::object::UID,
        alias: 0x1::string::String,
    }

    struct AccountRequest {
        account: address,
    }

    struct ACCOUNT has drop {
        dummy_field: bool,
    }

    public fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Account {
        Account{
            id    : 0x2::object::new(arg1),
            alias : arg0,
        }
    }

    public fun destroy(arg0: AccountRequest) : address {
        let AccountRequest { account: v0 } = arg0;
        v0
    }

    fun init(arg0: ACCOUNT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ACCOUNT>(arg0, arg1);
    }

    public fun receive<T0: store + key>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun request(arg0: &0x2::tx_context::TxContext) : AccountRequest {
        AccountRequest{account: 0x2::tx_context::sender(arg0)}
    }

    public fun request_with_account(arg0: &Account) : AccountRequest {
        let v0 = 0x2::object::id<Account>(arg0);
        AccountRequest{account: 0x2::object::id_to_address(&v0)}
    }

    // decompiled from Move bytecode v6
}

