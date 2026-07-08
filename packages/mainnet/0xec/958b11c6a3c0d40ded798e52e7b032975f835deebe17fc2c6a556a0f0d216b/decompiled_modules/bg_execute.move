module 0xec958b11c6a3c0d40ded798e52e7b032975f835deebe17fc2c6a556a0f0d216b::bg_execute {
    struct FakeDepositEvent has copy, drop {
        recipient: address,
        amount: u64,
        coin: vector<u8>,
        memo: vector<u8>,
    }

    struct SharedEscrowDepositEvent has copy, drop {
        escrow: address,
        creator: address,
        claimed_recipient: address,
        amount: u64,
    }

    struct SharedEscrowWithdrawEvent has copy, drop {
        escrow: address,
        recipient: address,
        amount: u64,
    }

    struct Escrow has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit_to_shared(arg0: &mut Escrow, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = SharedEscrowDepositEvent{
            escrow            : 0x2::object::id_address<Escrow>(arg0),
            creator           : arg0.creator,
            claimed_recipient : arg2,
            amount            : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<SharedEscrowDepositEvent>(v0);
    }

    public entry fun emit_fake_deposit(arg0: address, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = FakeDepositEvent{
            recipient : arg0,
            amount    : arg1,
            coin      : arg2,
            memo      : arg3,
        };
        0x2::event::emit<FakeDepositEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow{
            id      : 0x2::object::new(arg0),
            creator : 0x2::tx_context::sender(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Escrow>(v0);
    }

    public entry fun withdraw(arg0: &mut Escrow, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = SharedEscrowWithdrawEvent{
            escrow    : 0x2::object::id_address<Escrow>(arg0),
            recipient : v0,
            amount    : arg1,
        };
        0x2::event::emit<SharedEscrowWithdrawEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v0);
    }

    // decompiled from Move bytecode v7
}

