module 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::transfer_policy {
    struct TransferPolicy<phantom T0> has store {
        recipients: 0x2::table::Table<0x1::ascii::String, address>,
        per_transfer: u64,
        daily: u64,
        meter: 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::Meter,
    }

    struct Transferred has copy, drop {
        controller: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: 0x1::ascii::String,
        to: address,
    }

    public fun new<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : TransferPolicy<T0> {
        assert!(arg0 > 0 && arg1 >= arg0, 4);
        TransferPolicy<T0>{
            recipients   : 0x2::table::new<0x1::ascii::String, address>(arg3),
            per_transfer : arg0,
            daily        : arg1,
            meter        : 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::new(arg2),
        }
    }

    public fun used_today<T0>(arg0: &TransferPolicy<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::used_today(&arg0.meter, arg1)
    }

    public fun add_recipient<T0>(arg0: &mut TransferPolicy<T0>, arg1: 0x1::ascii::String, arg2: address) {
        assert!(!0x2::table::contains<0x1::ascii::String, address>(&arg0.recipients, arg1), 3);
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.recipients, arg1, arg2);
    }

    public fun daily<T0>(arg0: &TransferPolicy<T0>) : u64 {
        arg0.daily
    }

    public fun destroy<T0>(arg0: TransferPolicy<T0>) {
        let TransferPolicy {
            recipients   : v0,
            per_transfer : _,
            daily        : _,
            meter        : _,
        } = arg0;
        0x2::table::drop<0x1::ascii::String, address>(v0);
    }

    public(friend) fun execute<T0>(arg0: &mut TransferPolicy<T0>, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: 0x1::ascii::String, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        assert!(v0 <= arg0.per_transfer, 1);
        assert!(0x2::table::contains<0x1::ascii::String, address>(&arg0.recipients, arg3), 0);
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::charge(&mut arg0.meter, v0, arg0.daily, arg4);
        let v1 = *0x2::table::borrow<0x1::ascii::String, address>(&arg0.recipients, arg3);
        0x2::balance::send_funds<T0>(arg2, v1);
        let v2 = Transferred{
            controller : arg1,
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            amount     : v0,
            recipient  : arg3,
            to         : v1,
        };
        0x2::event::emit<Transferred>(v2);
    }

    public fun has_recipient<T0>(arg0: &TransferPolicy<T0>, arg1: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::ascii::String, address>(&arg0.recipients, arg1)
    }

    public fun per_transfer<T0>(arg0: &TransferPolicy<T0>) : u64 {
        arg0.per_transfer
    }

    public fun recipient<T0>(arg0: &TransferPolicy<T0>, arg1: 0x1::ascii::String) : address {
        *0x2::table::borrow<0x1::ascii::String, address>(&arg0.recipients, arg1)
    }

    // decompiled from Move bytecode v7
}

