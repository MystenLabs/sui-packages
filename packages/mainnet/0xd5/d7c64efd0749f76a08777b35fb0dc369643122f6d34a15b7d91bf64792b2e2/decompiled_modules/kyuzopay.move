module 0xd5d7c64efd0749f76a08777b35fb0dc369643122f6d34a15b7d91bf64792b2e2::kyuzopay {
    struct KYUZOPAY has drop {
        dummy_field: bool,
    }

    struct PaymentEvent has copy, drop {
        user: address,
        amount: u64,
        order_id: u64,
    }

    struct PayData has key {
        id: 0x2::object::UID,
        admin: address,
        payee: address,
    }

    public fun pay(arg0: &PayData, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        0x2::pay::join<0x2::sui::SUI>(&mut v1, arg2);
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v0, arg0.payee, arg3);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        let v2 = PaymentEvent{
            user     : 0x2::tx_context::sender(arg3),
            amount   : v0,
            order_id : arg1,
        };
        0x2::event::emit<PaymentEvent>(v2);
    }

    public fun admin(arg0: &PayData) : address {
        arg0.admin
    }

    fun init(arg0: KYUZOPAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<KYUZOPAY>(arg0, arg1);
        let v0 = PayData{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
            payee : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<PayData>(v0);
    }

    public fun transfer_admin(arg0: &mut PayData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public fun update_payee(arg0: &mut PayData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.payee = arg1;
    }

    // decompiled from Move bytecode v6
}

