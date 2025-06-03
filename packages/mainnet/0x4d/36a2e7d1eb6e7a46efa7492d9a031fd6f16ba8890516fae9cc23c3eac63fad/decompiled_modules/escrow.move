module 0x4d36a2e7d1eb6e7a46efa7492d9a031fd6f16ba8890516fae9cc23c3eac63fad::escrow {
    struct PaymentDeposited has copy, drop {
        appointment_id: vector<u8>,
        client: address,
        amount: u64,
    }

    struct PaymentReleased has copy, drop {
        appointment_id: vector<u8>,
        lawyer: address,
        amount: u64,
    }

    struct PaymentRefunded has copy, drop {
        appointment_id: vector<u8>,
        client: address,
        amount: u64,
    }

    struct Escrow has key {
        id: 0x2::object::UID,
        appointment_id: vector<u8>,
        amount: u64,
        client: address,
        lawyer: address,
        is_completed: bool,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_payment(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = Escrow{
            id             : 0x2::object::new(arg3),
            appointment_id : arg0,
            amount         : v0,
            client         : 0x2::tx_context::sender(arg3),
            lawyer         : arg1,
            is_completed   : false,
            coin           : arg2,
        };
        let v2 = PaymentDeposited{
            appointment_id : v1.appointment_id,
            client         : 0x2::tx_context::sender(arg3),
            amount         : v0,
        };
        0x2::event::emit<PaymentDeposited>(v2);
        0x2::transfer::share_object<Escrow>(v1);
    }

    public fun get_escrow_info(arg0: &Escrow) : (address, address, u64, bool) {
        (arg0.client, arg0.lawyer, arg0.amount, arg0.is_completed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun refund_to_client(arg0: &AdminCap, arg1: &mut Escrow, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_completed, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.coin, 0x2::coin::value<0x2::sui::SUI>(&arg1.coin), arg2), arg1.client);
        arg1.is_completed = true;
        let v0 = PaymentRefunded{
            appointment_id : arg1.appointment_id,
            client         : arg1.client,
            amount         : arg1.amount,
        };
        0x2::event::emit<PaymentRefunded>(v0);
    }

    public entry fun release_to_lawyer(arg0: &AdminCap, arg1: &mut Escrow, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_completed, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.coin, 0x2::coin::value<0x2::sui::SUI>(&arg1.coin), arg2), arg1.lawyer);
        arg1.is_completed = true;
        let v0 = PaymentReleased{
            appointment_id : arg1.appointment_id,
            lawyer         : arg1.lawyer,
            amount         : arg1.amount,
        };
        0x2::event::emit<PaymentReleased>(v0);
    }

    // decompiled from Move bytecode v6
}

