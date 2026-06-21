module 0xa1267a62b0accbb5347d857b2524f4f0429a985a9a09d10608cfff2ec39f9f4c::safesend {
    struct SafePayment<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        recipient_email: 0x1::string::String,
        balance: 0x1::option::Option<0x2::coin::Coin<T0>>,
        release_time: u64,
        claimed: bool,
    }

    struct PaymentCreated has copy, drop {
        payment_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        recipient_email: 0x1::string::String,
        amount: u64,
        release_time: u64,
    }

    struct PaymentClaimed has copy, drop {
        payment_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct PaymentCancelled has copy, drop {
        payment_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    public fun sender<T0>(arg0: &SafePayment<T0>) : address {
        arg0.sender
    }

    public fun cancel_payment<T0>(arg0: &mut SafePayment<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.sender, 2);
        assert!(!arg0.claimed, 1);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.release_time, 3);
        arg0.claimed = true;
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        let v2 = PaymentCancelled{
            payment_id : 0x2::object::uid_to_inner(&arg0.id),
            sender     : v0,
            amount     : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<PaymentCancelled>(v2);
    }

    public fun claim_payment<T0>(arg0: &mut SafePayment<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.release_time, 4);
        arg0.claimed = true;
        let v0 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0.balance);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = 0x2::tx_context::sender(arg2);
        arg0.recipient = v2;
        let v3 = v1 / 1000;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v3, arg2), @0x804450ab336a932a58bc75dc7968b1903b685995a0e14c75babc3e4c7c84ff79);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        let v4 = PaymentClaimed{
            payment_id : 0x2::object::uid_to_inner(&arg0.id),
            recipient  : v2,
            amount     : v1,
        };
        0x2::event::emit<PaymentClaimed>(v4);
    }

    public fun create_payment<T0>(arg0: address, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4) + arg3;
        let v2 = 0x2::object::new(arg5);
        let v3 = SafePayment<T0>{
            id              : v2,
            sender          : v0,
            recipient       : arg0,
            recipient_email : arg1,
            balance         : 0x1::option::some<0x2::coin::Coin<T0>>(arg2),
            release_time    : v1,
            claimed         : false,
        };
        0x2::transfer::share_object<SafePayment<T0>>(v3);
        let v4 = PaymentCreated{
            payment_id      : 0x2::object::uid_to_inner(&v2),
            sender          : v0,
            recipient       : arg0,
            recipient_email : arg1,
            amount          : 0x2::coin::value<T0>(&arg2),
            release_time    : v1,
        };
        0x2::event::emit<PaymentCreated>(v4);
    }

    public fun is_claimed<T0>(arg0: &SafePayment<T0>) : bool {
        arg0.claimed
    }

    public fun recipient<T0>(arg0: &SafePayment<T0>) : address {
        arg0.recipient
    }

    public fun recipient_email<T0>(arg0: &SafePayment<T0>) : 0x1::string::String {
        arg0.recipient_email
    }

    public fun release_payment<T0>(arg0: &mut SafePayment<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.release_time, 4);
        arg0.claimed = true;
        let v0 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0.balance);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = arg0.recipient;
        let v3 = v1 / 1000;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v3, arg2), @0x804450ab336a932a58bc75dc7968b1903b685995a0e14c75babc3e4c7c84ff79);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        let v4 = PaymentClaimed{
            payment_id : 0x2::object::uid_to_inner(&arg0.id),
            recipient  : v2,
            amount     : v1,
        };
        0x2::event::emit<PaymentClaimed>(v4);
    }

    public fun release_time<T0>(arg0: &SafePayment<T0>) : u64 {
        arg0.release_time
    }

    // decompiled from Move bytecode v7
}

