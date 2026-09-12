module 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_events {
    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        wrapper_id: 0x2::object::ID,
        owner: address,
        self_owned: bool,
        referrer_account_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct AppAuthorized has copy, drop {
        app: 0x1::ascii::String,
    }

    struct AppDeauthorized has copy, drop {
        app: 0x1::ascii::String,
    }

    struct Deposited has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        new_balance: u64,
    }

    struct Withdrawn has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        new_balance: u64,
    }

    struct FundsSettled has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        new_balance: u64,
    }

    public(friend) fun emit_account_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: 0x1::option::Option<0x2::object::ID>) {
        let v0 = AccountCreated{
            account_id          : arg0,
            wrapper_id          : arg1,
            owner               : arg2,
            self_owned          : arg3,
            referrer_account_id : arg4,
        };
        0x2::event::emit<AccountCreated>(v0);
    }

    public(friend) fun emit_app_authorized(arg0: 0x1::ascii::String) {
        let v0 = AppAuthorized{app: arg0};
        0x2::event::emit<AppAuthorized>(v0);
    }

    public(friend) fun emit_app_deauthorized(arg0: 0x1::ascii::String) {
        let v0 = AppDeauthorized{app: arg0};
        0x2::event::emit<AppDeauthorized>(v0);
    }

    public(friend) fun emit_deposited(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = Deposited{
            account_id  : arg0,
            coin_type   : arg1,
            amount      : arg2,
            new_balance : arg3,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_funds_settled(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = FundsSettled{
            account_id  : arg0,
            coin_type   : arg1,
            amount      : arg2,
            new_balance : arg3,
        };
        0x2::event::emit<FundsSettled>(v0);
    }

    public(friend) fun emit_withdrawn(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = Withdrawn{
            account_id  : arg0,
            coin_type   : arg1,
            amount      : arg2,
            new_balance : arg3,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

