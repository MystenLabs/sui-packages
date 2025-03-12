module 0x57ac46a3079b1346201739fbb9aa5df081e4a2f5f4b8146f249b176d7b2ea769::FeeCollector {
    struct FeeCollector has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct FeesCollected has copy, drop {
        integrator: address,
        integrator_name: 0x1::string::String,
        integrator_fee: u64,
        lifi_fee: u64,
        lifi_owner: address,
        tool: 0x1::string::String,
        receiver: 0x1::string::String,
        destination_chain_id: 0x1::string::String,
        fee_token_type: 0x1::string::String,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    public fun collect_token_fees<T0>(arg0: &FeeCollector, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg8) >= arg3 + arg4, 0);
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg8, arg3, arg9), arg1);
        };
        if (arg4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg8, arg4, arg9), arg0.owner);
        };
        let v0 = FeesCollected{
            integrator           : arg1,
            integrator_name      : arg2,
            integrator_fee       : arg3,
            lifi_fee             : arg4,
            lifi_owner           : arg0.owner,
            tool                 : arg5,
            receiver             : arg6,
            destination_chain_id : arg7,
            fee_token_type       : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
        };
        0x2::event::emit<FeesCollected>(v0);
        arg8
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

