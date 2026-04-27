module 0xef7782f310fad2b5a1cc3e5ec650b6bc2878b7684a63a662d604c42e16248b63::send_fund_poc {
    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        owner: address,
    }

    struct FundsReceived has copy, drop {
        vault_id: address,
        amount: u64,
        recipient: address,
    }

    public fun redeem_funds<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 13906834479286059007);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg1)), arg2), arg0.owner);
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        let v1 = VaultCreated{
            vault_id : 0x2::object::uid_to_address(&v0.id),
            owner    : v0.owner,
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun receive_to_owner<T0>(arg0: &mut Vault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        let v1 = arg0.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v1);
        let v2 = FundsReceived{
            vault_id  : 0x2::object::uid_to_address(&arg0.id),
            amount    : 0x2::coin::value<T0>(&v0),
            recipient : v1,
        };
        0x2::event::emit<FundsReceived>(v2);
    }

    // decompiled from Move bytecode v7
}

