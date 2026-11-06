module 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        destination: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<DestinationKey, address>,
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
            destination : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<DestinationKey, address>(v1, &v0, arg0, 172800000),
        }
    }

    public fun delay_ms(arg0: &Treasury) : u64 {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::delay_ms<DestinationKey, address>(&arg0.destination)
    }

    public fun is_guarded(arg0: &Treasury) : bool {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_guarded<DestinationKey, address>(&arg0.destination)
    }

    public fun apply_destination(arg0: &mut Treasury, arg1: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<DestinationKey, address>(&mut arg0.destination, arg1);
    }

    public fun cancel_destination(arg0: &mut Treasury, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<DestinationKey, address>(&mut arg0.destination);
    }

    public fun destination(arg0: &Treasury) : address {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<DestinationKey, address>(&arg0.destination)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Treasury>(new(@0x818d6d7026632f82367a9ca2413a5bb28aeec2a1b8dedca919ef812577b4d0a2, arg0));
    }

    public fun is_destination_ready(arg0: &Treasury, arg1: &0x2::clock::Clock) : bool {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_ready<DestinationKey, address>(&arg0.destination, arg1)
    }

    public fun pending_destination(arg0: &Treasury) : 0x1::option::Option<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<address>> {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::pending<DestinationKey, address>(&arg0.destination)
    }

    public fun schedule_destination(arg0: &mut Treasury, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::TreasuryAdmin>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 != @0x0, 5);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule<DestinationKey, address>(&mut arg0.destination, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

