module 0x8efcd68901a319c05c996da21085f1684f61be138b4315c4d1fe843d7e4fabf4::payment_receiver {
    struct PaymentConfig<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        receiver: 0x1::option::Option<address>,
        total_received: u64,
        payment_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentEvent has copy, drop {
        payer: address,
        receiver: address,
        amount: u64,
        payment_id: u64,
        token_type: 0x1::ascii::String,
    }

    struct ReceiverUpdatedEvent has copy, drop {
        old_receiver: 0x1::option::Option<address>,
        new_receiver: address,
        token_type: 0x1::ascii::String,
    }

    struct ConfigCreatedEvent has copy, drop {
        config_id: address,
        admin: address,
        token_type: 0x1::ascii::String,
    }

    public entry fun create_config<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PaymentConfig<T0>{
            id             : 0x2::object::new(arg1),
            admin          : v0,
            receiver       : 0x1::option::none<address>(),
            total_received : 0,
            payment_count  : 0,
        };
        let v2 = ConfigCreatedEvent{
            config_id  : 0x2::object::uid_to_address(&v1.id),
            admin      : v0,
            token_type : 0x1::ascii::string(b"Custom Token"),
        };
        0x2::event::emit<ConfigCreatedEvent>(v2);
        0x2::transfer::share_object<PaymentConfig<T0>>(v1);
    }

    public fun get_admin<T0>(arg0: &PaymentConfig<T0>) : address {
        arg0.admin
    }

    public fun get_payment_count<T0>(arg0: &PaymentConfig<T0>) : u64 {
        arg0.payment_count
    }

    public fun get_receiver<T0>(arg0: &PaymentConfig<T0>) : 0x1::option::Option<address> {
        arg0.receiver
    }

    public fun get_total_received<T0>(arg0: &PaymentConfig<T0>) : u64 {
        arg0.total_received
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun pay<T0>(arg0: &mut PaymentConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.receiver), 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = *0x1::option::borrow<address>(&arg0.receiver);
        arg0.total_received = arg0.total_received + v0;
        arg0.payment_count = arg0.payment_count + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v1);
        let v2 = PaymentEvent{
            payer      : 0x2::tx_context::sender(arg2),
            receiver   : v1,
            amount     : v0,
            payment_id : arg0.payment_count,
            token_type : 0x1::ascii::string(b"Custom Token"),
        };
        0x2::event::emit<PaymentEvent>(v2);
    }

    public entry fun pay_amount<T0>(arg0: &mut PaymentConfig<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.receiver), 3);
        assert!(arg2 > 0, 2);
        let v0 = *0x1::option::borrow<address>(&arg0.receiver);
        arg0.total_received = arg0.total_received + arg2;
        arg0.payment_count = arg0.payment_count + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2, arg3), v0);
        let v1 = PaymentEvent{
            payer      : 0x2::tx_context::sender(arg3),
            receiver   : v0,
            amount     : arg2,
            payment_id : arg0.payment_count,
            token_type : 0x1::ascii::string(b"Custom Token"),
        };
        0x2::event::emit<PaymentEvent>(v1);
    }

    public entry fun set_receiver<T0>(arg0: &AdminCap, arg1: &mut PaymentConfig<T0>, arg2: address) {
        arg1.receiver = 0x1::option::some<address>(arg2);
        let v0 = ReceiverUpdatedEvent{
            old_receiver : arg1.receiver,
            new_receiver : arg2,
            token_type   : 0x1::ascii::string(b"Custom Token"),
        };
        0x2::event::emit<ReceiverUpdatedEvent>(v0);
    }

    public entry fun update_admin<T0>(arg0: &AdminCap, arg1: &mut PaymentConfig<T0>, arg2: address) {
        arg1.admin = arg2;
    }

    // decompiled from Move bytecode v6
}

