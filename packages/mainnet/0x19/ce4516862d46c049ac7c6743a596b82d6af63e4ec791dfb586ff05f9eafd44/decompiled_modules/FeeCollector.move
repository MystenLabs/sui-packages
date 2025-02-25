module 0x19ce4516862d46c049ac7c6743a596b82d6af63e4ec791dfb586ff05f9eafd44::FeeCollector {
    struct FeeCollector has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct FeesCollected has copy, drop {
        integrator: address,
        integrator_fee: u64,
        lifi_fee: u64,
        lifi_owner: address,
        tool: 0x1::string::String,
        receiver: 0x1::string::String,
        destination_chain_id: 0x1::string::String,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    public fun collect_token_fees(arg0: &FeeCollector, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg2 + arg3, 0);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg2, arg8), arg1);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg3, arg8), arg0.owner);
        };
        let v0 = FeesCollected{
            integrator           : arg1,
            integrator_fee       : arg2,
            lifi_fee             : arg3,
            lifi_owner           : arg0.owner,
            tool                 : arg4,
            receiver             : arg5,
            destination_chain_id : arg6,
        };
        0x2::event::emit<FeesCollected>(v0);
        arg7
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollector{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeCollector>(v0);
    }

    public entry fun transfer_ownership(arg0: &mut FeeCollector, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
        let v0 = OwnershipTransferred{
            previous_owner : arg0.owner,
            new_owner      : arg1,
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    // decompiled from Move bytecode v6
}

