module 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        destination: 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::Delayed<DestinationKey, address>,
    }

    struct DestinationKey has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Treasury {
        assert!(arg0 != @0x0, 5);
        let v0 = 0x2::object::new(arg1);
        let v1 = DestinationKey{dummy_field: false};
        Treasury{
            id          : v0,
            destination : 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::new<DestinationKey, address>(v1, &v0, arg0, 172800000),
        }
    }

    public fun delay_ms(arg0: &Treasury) : u64 {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::delay_ms<DestinationKey, address>(&arg0.destination)
    }

    public fun is_guarded(arg0: &Treasury) : bool {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::is_guarded<DestinationKey, address>(&arg0.destination)
    }

    public fun apply_destination(arg0: &mut Treasury, arg1: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::apply<DestinationKey, address>(&mut arg0.destination, arg1);
    }

    public fun cancel_destination(arg0: &mut Treasury, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::CancelAdmin>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::cancel<DestinationKey, address>(&mut arg0.destination);
    }

    public fun destination(arg0: &Treasury) : address {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::value<DestinationKey, address>(&arg0.destination)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Treasury>(new(@0x35ed9963c1bceed273e0765983de1071fc7942d126be95a21609d3ce4ec5f023, arg0));
    }

    public fun is_destination_ready(arg0: &Treasury, arg1: &0x2::clock::Clock) : bool {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::is_ready<DestinationKey, address>(&arg0.destination, arg1)
    }

    public fun pending_destination(arg0: &Treasury) : 0x1::option::Option<0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::Proposal<address>> {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::pending<DestinationKey, address>(&arg0.destination)
    }

    public fun schedule_destination(arg0: &mut Treasury, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::TreasuryAdmin>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 != @0x0, 5);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::schedule<DestinationKey, address>(&mut arg0.destination, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

