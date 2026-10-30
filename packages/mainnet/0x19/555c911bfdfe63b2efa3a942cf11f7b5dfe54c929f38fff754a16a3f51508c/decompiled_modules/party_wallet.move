module 0x19555c911bfdfe63b2efa3a942cf11f7b5dfe54c929f38fff754a16a3f51508c::party_wallet {
    struct PartyObjectReceivedEvent<phantom T0> has copy, drop {
        party_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
    }

    struct PartyCoinsReceivedEvent<phantom T0> has copy, drop {
        party_id: 0x2::object::ID,
        value: u64,
        coins: u64,
    }

    struct PartyFundsRedeemedEvent<phantom T0> has copy, drop {
        party_id: 0x2::object::ID,
        value: u64,
    }

    public fun inbox_address(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : address {
        let v0 = 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun receive<T0: store + key>(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: 0x2::transfer::Receiving<T0>) : T0 {
        let v0 = 0x2::transfer::public_receive<T0>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1), arg2);
        let v1 = PartyObjectReceivedEvent<T0>{
            party_id  : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            object_id : 0x2::object::id<T0>(&v0),
        };
        0x2::event::emit<PartyObjectReceivedEvent<T0>>(v1);
        v0
    }

    public fun receive_balance<T0>(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : 0x2::balance::Balance<T0> {
        assert!(!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2), 0);
        let v0 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::receive_coins_as_balance<T0>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1), arg2);
        let v1 = PartyCoinsReceivedEvent<T0>{
            party_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            value    : 0x2::balance::value<T0>(&v0),
            coins    : 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2),
        };
        0x2::event::emit<PartyCoinsReceivedEvent<T0>>(v1);
        v0
    }

    public fun redeem_balance<T0>(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        assert!(arg2 > 0, 1);
        let v1 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_balance<T0>(v0, arg2);
        let v2 = PartyFundsRedeemedEvent<T0>{
            party_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            value    : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<PartyFundsRedeemedEvent<T0>>(v2);
        v1
    }

    // decompiled from Move bytecode v7
}

