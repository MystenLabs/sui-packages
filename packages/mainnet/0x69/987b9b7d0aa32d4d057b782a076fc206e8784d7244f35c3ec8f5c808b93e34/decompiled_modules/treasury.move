module 0x69987b9b7d0aa32d4d057b782a076fc206e8784d7244f35c3ec8f5c808b93e34::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun withdraw_all(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)), arg1), @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2);
    }

    public entry fun withdraw_amount(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg2), @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2);
    }

    // decompiled from Move bytecode v6
}

