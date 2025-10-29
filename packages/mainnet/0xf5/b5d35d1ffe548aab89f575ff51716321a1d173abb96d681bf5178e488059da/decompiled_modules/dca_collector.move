module 0x101ceaafe0660e492c7b3f27525d52b5fb42992eeb5181eb19621ea89d1bd637::dca_collector {
    struct DcaCollector has store, key {
        id: 0x2::object::UID,
        protocol_fee_claim_cap: 0x1::option::Option<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>,
        deposit_cap: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap,
    }

    struct CreateDcaCollectorEvent has copy, drop, store {
        id: 0x2::object::ID,
        deposit_cap_id: 0x2::object::ID,
    }

    struct DisableDcaCollectorEvent has copy, drop, store {
        id: 0x2::object::ID,
        claim_cap_id: 0x2::object::ID,
    }

    public fun claim_protocol_fee<T0>(arg0: &mut DcaCollector, arg1: &mut 0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::ProtocolFeeVault, arg2: &mut 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::Vault, arg3: &0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::GlobalConfig, arg4: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned) {
        assert!(0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::vault_id(&arg0.deposit_cap) == 0x2::object::id<0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::Vault>(arg2), 13906834492170960897);
        assert!(0x1::option::is_some<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(&arg0.protocol_fee_claim_cap), 13906834496466059267);
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::deposit<T0>(arg2, 0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::claim_fee_with_cap<T0>(arg3, arg1, 0x1::option::borrow<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(&arg0.protocol_fee_claim_cap)), &mut arg0.deposit_cap, arg4);
    }

    public fun create_dca_collector(arg0: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap, arg1: 0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap, arg2: &0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun create_dca_collector_v2(arg0: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap, arg1: 0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap, arg2: &0x101ceaafe0660e492c7b3f27525d52b5fb42992eeb5181eb19621ea89d1bd637::admin_cap::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DcaCollector{
            id                     : 0x2::object::new(arg3),
            protocol_fee_claim_cap : 0x1::option::some<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(arg1),
            deposit_cap            : arg0,
        };
        let v1 = CreateDcaCollectorEvent{
            id             : 0x2::object::id<DcaCollector>(&v0),
            deposit_cap_id : 0x2::object::id<0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap>(&arg0),
        };
        0x2::event::emit<CreateDcaCollectorEvent>(v1);
        0x2::transfer::public_share_object<DcaCollector>(v0);
    }

    public fun disable_collector(arg0: &mut DcaCollector, arg1: &0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun disable_collector_v2(arg0: &mut DcaCollector, arg1: &0x101ceaafe0660e492c7b3f27525d52b5fb42992eeb5181eb19621ea89d1bd637::admin_cap::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::extract<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(&mut arg0.protocol_fee_claim_cap);
        0x2::transfer::public_transfer<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(v0, 0x2::tx_context::sender(arg2));
        let v1 = DisableDcaCollectorEvent{
            id           : 0x2::object::id<DcaCollector>(arg0),
            claim_cap_id : 0x2::object::id<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(&v0),
        };
        0x2::event::emit<DisableDcaCollectorEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

