module 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        destination: 0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::Delayed<DestinationKey, address>,
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
            destination : 0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::new<DestinationKey, address>(v1, &v0, arg0, 172800000),
        }
    }

    public fun delay_ms(arg0: &Treasury) : u64 {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::delay_ms<DestinationKey, address>(&arg0.destination)
    }

    public fun is_guarded(arg0: &Treasury) : bool {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::is_guarded<DestinationKey, address>(&arg0.destination)
    }

    public fun apply_destination(arg0: &mut Treasury, arg1: &0x2::clock::Clock) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::apply<DestinationKey, address>(&mut arg0.destination, arg1);
    }

    public fun cancel_destination(arg0: &mut Treasury, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_domain::CancelAdmin>) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::cancel<DestinationKey, address>(&mut arg0.destination);
    }

    public fun destination(arg0: &Treasury) : address {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::value<DestinationKey, address>(&arg0.destination)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Treasury>(new(@0x818d6d7026632f82367a9ca2413a5bb28aeec2a1b8dedca919ef812577b4d0a2, arg0));
    }

    public fun is_destination_ready(arg0: &Treasury, arg1: &0x2::clock::Clock) : bool {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::is_ready<DestinationKey, address>(&arg0.destination, arg1)
    }

    public fun pending_destination(arg0: &Treasury) : 0x1::option::Option<0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::Proposal<address>> {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::pending<DestinationKey, address>(&arg0.destination)
    }

    public fun schedule_destination(arg0: &mut Treasury, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_domain::TreasuryAdmin>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 != @0x0, 5);
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed::schedule<DestinationKey, address>(&mut arg0.destination, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

