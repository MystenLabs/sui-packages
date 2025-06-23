module 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::token_interface {
    public(friend) fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::tlp::TLP>(), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::liquidity_token_not_existed());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::tlp::burn<T0>(arg0, arg1)
    }

    public(friend) fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::tlp::TLP>(), 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error::liquidity_token_not_existed());
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::tlp::mint<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

