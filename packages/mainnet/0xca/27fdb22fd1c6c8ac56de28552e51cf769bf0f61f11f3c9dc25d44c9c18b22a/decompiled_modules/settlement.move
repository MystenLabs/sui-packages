module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::settlement {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
    }

    struct Escrow has store, key {
        id: 0x2::object::UID,
        payer: address,
        payee: address,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        amount: u64,
        released: bool,
        locked_at: u64,
    }

    struct EscrowLocked has copy, drop {
        escrow_id: address,
        payer: address,
        payee: address,
        amount: u64,
    }

    struct EscrowReleased has copy, drop {
        escrow_id: address,
        payee: address,
        net_amount: u64,
        fee: u64,
    }

    struct EscrowRefunded has copy, drop {
        escrow_id: address,
        payer: address,
        amount: u64,
    }

    struct DisputeResolved has copy, drop {
        escrow_id: address,
        payer_amount: u64,
        payee_amount: u64,
    }

    public fun escrow_amount(arg0: &Escrow) : u64 {
        arg0.amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Treasury{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected : 0,
        };
        0x2::transfer::share_object<Treasury>(v1);
    }

    public fun is_released(arg0: &Escrow) : bool {
        arg0.released
    }

    entry fun lock_escrow(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Escrow{
            id        : 0x2::object::new(arg3),
            payer     : v1,
            payee     : arg0,
            funds     : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            amount    : v0,
            released  : false,
            locked_at : 0x2::clock::timestamp_ms(arg2),
        };
        let v3 = EscrowLocked{
            escrow_id : 0x2::object::uid_to_address(&v2.id),
            payer     : v1,
            payee     : arg0,
            amount    : v0,
        };
        0x2::event::emit<EscrowLocked>(v3);
        0x2::transfer::share_object<Escrow>(v2);
    }

    entry fun refund_escrow(arg0: &mut Escrow, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.released, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.payer, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.locked_at + 604800000, 4);
        arg0.released = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, arg0.amount), arg2), arg0.payer);
        let v0 = EscrowRefunded{
            escrow_id : 0x2::object::uid_to_address(&arg0.id),
            payer     : arg0.payer,
            amount    : arg0.amount,
        };
        0x2::event::emit<EscrowRefunded>(v0);
    }

    entry fun release_escrow(arg0: &mut Escrow, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.released, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.payer, 1);
        arg0.released = true;
        let v0 = arg0.amount;
        let v1 = v0 * 500 / 10000;
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v2), arg2), arg0.payee);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v1));
        arg1.total_collected = arg1.total_collected + v1;
        let v3 = EscrowReleased{
            escrow_id  : 0x2::object::uid_to_address(&arg0.id),
            payee      : arg0.payee,
            net_amount : v2,
            fee        : v1,
        };
        0x2::event::emit<EscrowReleased>(v3);
    }

    entry fun resolve_dispute(arg0: &AdminCap, arg1: &mut Escrow, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.released, 2);
        assert!(arg2 <= 10000, 3);
        arg1.released = true;
        let v0 = arg1.amount;
        let v1 = v0 * arg2 / 10000;
        let v2 = v0 - v1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.funds, v1), arg3), arg1.payer);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.funds, v2), arg3), arg1.payee);
        };
        let v3 = DisputeResolved{
            escrow_id    : 0x2::object::uid_to_address(&arg1.id),
            payer_amount : v1,
            payee_amount : v2,
        };
        0x2::event::emit<DisputeResolved>(v3);
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

