module 0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::loyalty_card {
    struct LoyaltyCard<phantom T0> has key {
        id: 0x2::object::UID,
        collection_logo: 0x1::string::String,
        emitter_logo: 0x1::string::String,
        background_image: 0x1::string::String,
        collection_name: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        holder_name: 0x1::string::String,
        tier_name: 0x1::string::String,
        tier: u8,
        points: u64,
        deployer_name: 0x1::string::String,
        deployer_id: 0x1::string::String,
        contract_address: address,
        point_name: 0x1::string::String,
    }

    struct LoyaltyCardOwnerCap<phantom T0> has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct TransferTicket<phantom T0> has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
        to: address,
        new_holder: 0x1::string::String,
    }

    public fun transfer<T0>(arg0: TransferTicket<T0>, arg1: &mut LoyaltyCard<T0>, arg2: LoyaltyCardOwnerCap<T0>) {
        let TransferTicket {
            id         : v0,
            for        : v1,
            to         : v2,
            new_holder : v3,
        } = arg0;
        assert!(0x2::object::id<LoyaltyCard<T0>>(arg1) == v1, 1);
        0x2::object::delete(v0);
        arg1.holder_name = v3;
        0x2::transfer::transfer<LoyaltyCardOwnerCap<T0>>(arg2, v2);
    }

    public fun delete_loyalty_card<T0>(arg0: &0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::AdminCap<T0>, arg1: LoyaltyCard<T0>) {
        let LoyaltyCard {
            id               : v0,
            collection_logo  : _,
            emitter_logo     : _,
            background_image : _,
            collection_name  : _,
            name             : _,
            description      : _,
            holder_name      : _,
            tier_name        : _,
            tier             : _,
            points           : _,
            deployer_name    : _,
            deployer_id      : _,
            contract_address : _,
            point_name       : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun mint<T0>(arg0: &0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::AdminCap<T0>, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u8, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: address, arg15: 0x1::string::String, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = LoyaltyCard<T0>{
            id               : 0x2::object::new(arg16),
            collection_logo  : arg2,
            emitter_logo     : arg3,
            background_image : arg4,
            collection_name  : arg5,
            name             : arg6,
            description      : arg7,
            holder_name      : arg8,
            tier_name        : arg9,
            tier             : arg10,
            points           : arg11,
            deployer_name    : arg12,
            deployer_id      : arg13,
            contract_address : arg14,
            point_name       : arg15,
        };
        0x2::transfer::transfer<LoyaltyCard<T0>>(v0, arg1);
    }

    public fun mint_transfer_ticket<T0>(arg0: &0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::AdminCap<T0>, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferTicket<T0>{
            id         : 0x2::object::new(arg5),
            for        : arg1,
            to         : arg2,
            new_holder : arg3,
        };
        0x2::transfer::transfer<TransferTicket<T0>>(v0, arg4);
    }

    public fun name<T0>(arg0: &LoyaltyCard<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun set_name<T0>(arg0: &0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::AdminCap<T0>, arg1: &mut LoyaltyCard<T0>, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    // decompiled from Move bytecode v6
}

