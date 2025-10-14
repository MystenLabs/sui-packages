module 0xfba4ddaf5ab940f2a1937fd21465a515852728ecee62cd82abaa433974264920::api_access_payment {
    struct APIAccessPayment has key {
        id: 0x2::object::UID,
        funds_receiver: address,
        access_fee: u64,
        owner: address,
        total_balance: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PaymentReceived has copy, drop {
        payer: address,
        amount: u64,
        timestamp: u64,
    }

    struct FeeUpdated has copy, drop {
        new_fee: u64,
        timestamp: u64,
    }

    struct FundsWithdrawn has copy, drop {
        amount_withdrawn: u64,
        timestamp: u64,
    }

    struct FundsReceiverChanged has copy, drop {
        old_receiver: address,
        new_receiver: address,
        timestamp: u64,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
        timestamp: u64,
    }

    struct ActionPayment has copy, drop {
        payer: address,
        action: vector<u8>,
        amount: u64,
        extra_data: vector<u8>,
        timestamp: u64,
    }

    public fun change_funds_receiver(arg0: &mut APIAccessPayment, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 != @0x0, 3);
        arg0.funds_receiver = arg1;
        let v0 = FundsReceiverChanged{
            old_receiver : arg0.funds_receiver,
            new_receiver : arg1,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FundsReceiverChanged>(v0);
    }

    public fun create_contract(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = APIAccessPayment{
            id             : 0x2::object::new(arg2),
            funds_receiver : arg0,
            access_fee     : arg1,
            owner          : 0x2::tx_context::sender(arg2),
            total_balance  : 0,
            vault          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<APIAccessPayment>(v0);
    }

    public fun get_access_fee(arg0: &APIAccessPayment) : u64 {
        arg0.access_fee
    }

    public fun get_funds_receiver(arg0: &APIAccessPayment) : address {
        arg0.funds_receiver
    }

    public fun get_owner(arg0: &APIAccessPayment) : address {
        arg0.owner
    }

    public fun get_total_balance(arg0: &APIAccessPayment) : u64 {
        arg0.total_balance
    }

    public fun get_vault_balance(arg0: &APIAccessPayment) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    public fun pay_for_action(arg0: &mut APIAccessPayment, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        arg0.total_balance = arg0.total_balance + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = ActionPayment{
            payer      : 0x2::tx_context::sender(arg5),
            action     : arg2,
            amount     : v0,
            extra_data : arg3,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ActionPayment>(v1);
    }

    public fun purchase_access_for(arg0: &mut APIAccessPayment, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 != arg0.owner, 5);
        assert!(v0 != arg0.funds_receiver, 6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.access_fee, 1);
        arg0.total_balance = arg0.total_balance + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = PaymentReceived{
            payer     : arg2,
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PaymentReceived>(v2);
    }

    public fun transfer_admin(arg0: &mut APIAccessPayment, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 != @0x0, 3);
        arg0.owner = arg1;
        let v0 = AdminChanged{
            old_admin : arg0.owner,
            new_admin : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public fun update_access_fee(arg0: &mut APIAccessPayment, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 > 0, 3);
        arg0.access_fee = arg1;
        let v0 = FeeUpdated{
            new_fee   : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun withdraw(arg0: &mut APIAccessPayment, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= arg1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1), arg3), arg0.funds_receiver);
        let v0 = FundsWithdrawn{
            amount_withdrawn : arg1,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FundsWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

