module 0x101ceaafe0660e492c7b3f27525d52b5fb42992eeb5181eb19621ea89d1bd637::dlmm_collector {
    struct DlmmCollector has store, key {
        id: 0x2::object::UID,
        protocol_fee_claim_cap: 0x1::option::Option<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap>,
        deposit_cap: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap,
    }

    struct CreateClmmCollectorEvent has copy, drop, store {
        id: 0x2::object::ID,
        claim_cap_id: 0x2::object::ID,
        deposit_cap_id: 0x2::object::ID,
    }

    struct DisableClmmCollectorEvent has copy, drop, store {
        id: 0x2::object::ID,
        claim_cap_id: 0x2::object::ID,
    }

    public fun claim_protocol_fee<T0, T1>(arg0: &mut DlmmCollector, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::Vault, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned) {
        assert!(0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::vault_id(&arg0.deposit_cap) == 0x2::object::id<0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::Vault>(arg2), 13906834449221287937);
        assert!(0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap>(&arg0.protocol_fee_claim_cap), 13906834453516386307);
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_protocol_fee_with_cap<T0, T1>(arg1, arg3, arg4, 0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap>(&arg0.protocol_fee_claim_cap));
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::deposit<T0>(arg2, v0, &mut arg0.deposit_cap, arg5);
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::deposit<T1>(arg2, v1, &mut arg0.deposit_cap, arg5);
    }

    public fun create_dlmm_collector(arg0: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap, arg1: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap, arg2: &0x101ceaafe0660e492c7b3f27525d52b5fb42992eeb5181eb19621ea89d1bd637::admin_cap::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DlmmCollector{
            id                     : 0x2::object::new(arg3),
            protocol_fee_claim_cap : 0x1::option::some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap>(arg0),
            deposit_cap            : arg1,
        };
        let v1 = CreateClmmCollectorEvent{
            id             : 0x2::object::id<DlmmCollector>(&v0),
            claim_cap_id   : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap>(&arg0),
            deposit_cap_id : 0x2::object::id<0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap>(&arg1),
        };
        0x2::event::emit<CreateClmmCollectorEvent>(v1);
        0x2::transfer::public_share_object<DlmmCollector>(v0);
    }

    public fun disable_collector(arg0: &mut DlmmCollector, arg1: &0x101ceaafe0660e492c7b3f27525d52b5fb42992eeb5181eb19621ea89d1bd637::admin_cap::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap>(&mut arg0.protocol_fee_claim_cap);
        0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap>(v0, 0x2::tx_context::sender(arg2));
        let v1 = DisableClmmCollectorEvent{
            id           : 0x2::object::id<DlmmCollector>(arg0),
            claim_cap_id : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::ProtocolFeeCollectCap>(&v0),
        };
        0x2::event::emit<DisableClmmCollectorEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

