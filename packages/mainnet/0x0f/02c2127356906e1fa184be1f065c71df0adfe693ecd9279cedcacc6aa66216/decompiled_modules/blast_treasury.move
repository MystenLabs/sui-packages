module 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        destination: 0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::Delayed<DestinationKey, address>,
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
            destination : 0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::new<DestinationKey, address>(v1, &v0, arg0, 172800000),
        }
    }

    public fun apply_destination(arg0: &mut Treasury, arg1: &0x2::clock::Clock) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::apply<DestinationKey, address>(&mut arg0.destination, arg1);
    }

    public fun cancel_destination(arg0: &mut Treasury, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::AdminWitness<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_domain::CancelAdmin>) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::cancel<DestinationKey, address>(&mut arg0.destination);
    }

    public fun delay_ms(arg0: &Treasury) : u64 {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::delay_ms<DestinationKey, address>(&arg0.destination)
    }

    public fun destination(arg0: &Treasury) : address {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::value<DestinationKey, address>(&arg0.destination)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Treasury>(new(@0xffc747a45e5f9ed7355fc03261f84156d6fc3497a7b88295f63ea9129f69ca0a, arg0));
    }

    public fun is_destination_ready(arg0: &Treasury, arg1: &0x2::clock::Clock) : bool {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::is_ready<DestinationKey, address>(&arg0.destination, arg1)
    }

    public fun is_guarded(arg0: &Treasury) : bool {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::is_guarded<DestinationKey, address>(&arg0.destination)
    }

    public fun pending_destination(arg0: &Treasury) : 0x1::option::Option<0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::Proposal<address>> {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::pending<DestinationKey, address>(&arg0.destination)
    }

    public fun schedule_destination(arg0: &mut Treasury, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::AdminWitness<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_domain::TreasuryAdmin>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 != @0x0, 5);
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::schedule<DestinationKey, address>(&mut arg0.destination, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

