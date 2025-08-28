module 0x65ee2e87bece09e09b8dbf496165bdfbf5b43a2875ea9b10edee651412ddc732::transfer_proof {
    struct MockCToken has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct MockStrategies has key {
        id: 0x2::object::UID,
        data: u64,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: u64,
    }

    fun create_mock_ctoken(arg0: &mut 0x2::tx_context::TxContext) : MockCToken {
        MockCToken{
            id     : 0x2::object::new(arg0),
            amount : 1000,
        }
    }

    public entry fun deposit_correct(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &MockStrategies, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.balance = arg0.balance + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = create_mock_ctoken(arg3);
        0x2::transfer::public_transfer<MockCToken>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            balance : 0,
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = MockStrategies{
            id   : 0x2::object::new(arg0),
            data : 42,
        };
        0x2::transfer::share_object<MockStrategies>(v1);
    }

    // decompiled from Move bytecode v6
}

