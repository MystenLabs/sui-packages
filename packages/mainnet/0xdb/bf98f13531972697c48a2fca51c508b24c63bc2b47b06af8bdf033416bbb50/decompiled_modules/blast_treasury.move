module 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        destination: 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::Delayed<DestinationKey, address>,
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
            destination : 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::new<DestinationKey, address>(v1, &v0, arg0, 172800000),
        }
    }

    public fun apply_destination(arg0: &mut Treasury, arg1: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::apply<DestinationKey, address>(&mut arg0.destination, arg1);
    }

    public fun cancel_destination(arg0: &mut Treasury, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::CancelAdmin>) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::cancel<DestinationKey, address>(&mut arg0.destination);
    }

    public fun delay_ms(arg0: &Treasury) : u64 {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::delay_ms<DestinationKey, address>(&arg0.destination)
    }

    public fun destination(arg0: &Treasury) : address {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::value<DestinationKey, address>(&arg0.destination)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Treasury>(new(@0xef468a16dd5ff69a5d35d23ab8ea5540f1410ff34a2f2b8f3f0d573de9df3598, arg0));
    }

    public fun is_destination_ready(arg0: &Treasury, arg1: &0x2::clock::Clock) : bool {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::is_ready<DestinationKey, address>(&arg0.destination, arg1)
    }

    public fun is_guarded(arg0: &Treasury) : bool {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::is_guarded<DestinationKey, address>(&arg0.destination)
    }

    public fun pending_destination(arg0: &Treasury) : 0x1::option::Option<0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::Proposal<address>> {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::pending<DestinationKey, address>(&arg0.destination)
    }

    public fun schedule_destination(arg0: &mut Treasury, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::TreasuryAdmin>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 != @0x0, 5);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::schedule<DestinationKey, address>(&mut arg0.destination, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

