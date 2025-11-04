module 0x8accdd0d7776b9bd5ca003c70f8d9bd830e549d1511cc4a98491d6ce0727e61d::dca_collector {
    struct DcaCollector has store, key {
        id: 0x2::object::UID,
        protocol_fee_claim_cap: 0x1::option::Option<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>,
        deposit_cap: 0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::DepositCap,
    }

    struct CreateDcaCollectorEvent has copy, drop, store {
        id: 0x2::object::ID,
        deposit_cap_id: 0x2::object::ID,
    }

    struct DisableDcaCollectorEvent has copy, drop, store {
        id: 0x2::object::ID,
        claim_cap_id: 0x2::object::ID,
    }

    public fun claim_protocol_fee<T0>(arg0: &DcaCollector, arg1: &mut 0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::ProtocolFeeVault, arg2: &mut 0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::Vault, arg3: &0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::GlobalConfig, arg4: &0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::versioned::Versioned) {
        assert!(0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::vault_id(&arg0.deposit_cap) == 0x2::object::id<0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::Vault>(arg2), 13906834449221287937);
        assert!(0x1::option::is_some<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(&arg0.protocol_fee_claim_cap), 13906834453516386307);
        0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::deposit<T0>(arg2, 0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::claim_fee_with_cap<T0>(arg3, arg1, 0x1::option::borrow<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(&arg0.protocol_fee_claim_cap)), &arg0.deposit_cap, arg4);
    }

    public fun create(arg0: 0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::DepositCap, arg1: 0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap, arg2: &0x8accdd0d7776b9bd5ca003c70f8d9bd830e549d1511cc4a98491d6ce0727e61d::admin_cap::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DcaCollector{
            id                     : 0x2::object::new(arg3),
            protocol_fee_claim_cap : 0x1::option::some<0x587614620d0d30aed66d86ffd3ba385a661a86aa573a4d579017068f561c6d8f::config::OperatorCap>(arg1),
            deposit_cap            : arg0,
        };
        let v1 = CreateDcaCollectorEvent{
            id             : 0x2::object::id<DcaCollector>(&v0),
            deposit_cap_id : 0x2::object::id<0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::DepositCap>(&arg0),
        };
        0x2::event::emit<CreateDcaCollectorEvent>(v1);
        0x2::transfer::public_share_object<DcaCollector>(v0);
    }

    public fun disable_collector_v2(arg0: &mut DcaCollector, arg1: &0x8accdd0d7776b9bd5ca003c70f8d9bd830e549d1511cc4a98491d6ce0727e61d::admin_cap::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
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

