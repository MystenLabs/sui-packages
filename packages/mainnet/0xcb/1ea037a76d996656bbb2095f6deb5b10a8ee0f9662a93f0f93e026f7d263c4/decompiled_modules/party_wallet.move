module 0xcb1ea037a76d996656bbb2095f6deb5b10a8ee0f9662a93f0f93e026f7d263c4::party_wallet {
    struct ObjectReceivedEvent<phantom T0> has copy, drop {
        party_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
    }

    struct CoinsReceivedEvent<phantom T0> has copy, drop {
        party_id: 0x2::object::ID,
        amount: u64,
        coins: u64,
    }

    struct FundsRedeemedEvent<phantom T0> has copy, drop {
        party_id: 0x2::object::ID,
        amount: u64,
    }

    public fun redeem_balance<T0>(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        assert!(arg2 > 0, 1);
        let v1 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_balance<T0>(v0, arg2);
        let v2 = FundsRedeemedEvent<T0>{
            party_id : 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0),
            amount   : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<FundsRedeemedEvent<T0>>(v2);
        v1
    }

    public fun inbox_address(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : address {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun receive<T0: store + key>(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: 0x2::transfer::Receiving<T0>) : T0 {
        let v0 = 0x2::transfer::public_receive<T0>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1), arg2);
        let v1 = ObjectReceivedEvent<T0>{
            party_id  : 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0),
            object_id : 0x2::object::id<T0>(&v0),
        };
        0x2::event::emit<ObjectReceivedEvent<T0>>(v1);
        v0
    }

    public fun receive_balance<T0>(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : 0x2::balance::Balance<T0> {
        assert!(!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2), 0);
        let v0 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::receive_coins_as_balance<T0>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1), arg2);
        let v1 = CoinsReceivedEvent<T0>{
            party_id : 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0),
            amount   : 0x2::balance::value<T0>(&v0),
            coins    : 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2),
        };
        0x2::event::emit<CoinsReceivedEvent<T0>>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

