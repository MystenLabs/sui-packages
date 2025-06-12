module 0x635f1e451c11e639170c4158ce80ce6dd59bba27f68be32ff0ac341aee2e8920::deposit {
    struct DepositController has key {
        id: 0x2::object::UID,
        target_address: address,
    }

    struct DEPOSIT has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        coin_type: 0x1::string::String,
        amount: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::string::String,
        amount: u64,
        receiver: address,
        idempotency_key: 0x1::string::String,
    }

    public fun deposit<T0>(arg0: &DepositController, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = DepositEvent{
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount    : 0x2::coin::value<T0>(&arg1),
            sender    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.target_address);
    }

    fun init(arg0: DEPOSIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DEPOSIT>(arg0, arg1);
        let v0 = DepositController{
            id             : 0x2::object::new(arg1),
            target_address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<DepositController>(v0);
    }

    public fun set_target_address(arg0: &mut DepositController, arg1: &AdminCap, arg2: address) {
        arg0.target_address = arg2;
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: 0x1::string::String) {
        let v0 = WithdrawEvent{
            coin_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount          : 0x2::coin::value<T0>(&arg1),
            receiver        : arg2,
            idempotency_key : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

