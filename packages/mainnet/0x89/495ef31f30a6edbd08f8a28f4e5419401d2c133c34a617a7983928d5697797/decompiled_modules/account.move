module 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account {
    struct ACCOUNT has drop {
        dummy_field: bool,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
        alias: 0x1::option::Option<0x1::string::String>,
    }

    struct AccountRequest has drop {
        account: address,
    }

    public fun new(arg0: 0x1::option::Option<0x1::string::String>, arg1: &mut 0x2::tx_context::TxContext) : Account {
        if (0x1::option::is_some<0x1::string::String>(&arg0) && 0x1::string::length(0x1::option::borrow<0x1::string::String>(&arg0)) > alias_length_limit()) {
            err_alias_length_too_long();
        };
        Account{
            id    : 0x2::object::new(arg1),
            alias : arg0,
        }
    }

    public fun account_address(arg0: &Account) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun alias_length_limit() : u64 {
        32
    }

    entry fun create(arg0: 0x1::option::Option<0x1::string::String>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0, arg1);
        0x2::transfer::transfer<Account>(v0, 0x2::tx_context::sender(arg1));
    }

    fun err_alias_length_too_long() {
        abort 101
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

    public fun request_address(arg0: &AccountRequest) : address {
        arg0.account
    }

    public fun request_with_account(arg0: &Account) : AccountRequest {
        let v0 = 0x2::object::id<Account>(arg0);
        AccountRequest{account: 0x2::object::id_to_address(&v0)}
    }

    public fun update_alias(arg0: &mut Account, arg1: 0x1::string::String) {
        if (0x1::string::length(&arg1) > alias_length_limit()) {
            err_alias_length_too_long();
        };
        if (0x1::option::is_some<0x1::string::String>(&arg0.alias)) {
            *0x1::option::borrow_mut<0x1::string::String>(&mut arg0.alias) = arg1;
        } else {
            0x1::option::fill<0x1::string::String>(&mut arg0.alias, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

