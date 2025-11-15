module 0xe945ec6c4e688d654025d375e321d709f67ed6935ccbd21e94abb66af63ea7b1::payfrica {
    struct OnRampEvent has copy, drop {
        receiver: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        fiat: 0x1::string::String,
        timestamp: u64,
    }

    struct OffRampRefundEvent has copy, drop {
        receiver: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        fiat: 0x1::string::String,
        timestamp: u64,
    }

    struct OffRampEvent has copy, drop {
        sender: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        fiat: 0x1::string::String,
        timestamp: u64,
    }

    public fun off_ramp<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1);
        let v0 = OffRampEvent{
            sender    : 0x2::tx_context::sender(arg3),
            amount    : 0x2::coin::value<T0>(&arg0),
            coin_type : 0x1::type_name::get<T0>(),
            fiat      : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OffRampEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x7aab130dfb21a710d53b8c17ec3e0783fc4f57d8d9dea1082154cd647c0e2f34);
    }

    public fun on_ramp<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1);
        let v0 = OnRampEvent{
            receiver  : arg2,
            amount    : 0x2::coin::value<T0>(&arg0),
            coin_type : 0x1::type_name::get<T0>(),
            fiat      : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OnRampEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    public fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1);
        let v0 = OffRampRefundEvent{
            receiver  : arg2,
            amount    : 0x2::coin::value<T0>(&arg0),
            coin_type : 0x1::type_name::get<T0>(),
            fiat      : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OffRampRefundEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

