module 0x918d9c2908cb36995c8d408129c8429b56afe9ff02bbb391b364c01a08317be5::aurora {
    struct ContractData has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x87c9e076815e78ee63b7dc225704c428b8c51072ccead4304ae07f6c68fe1b92, 1);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun aftermath_0<T0, T1, T2>(arg0: &mut AccessList, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(is_valid(arg0, arg8), 1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0, 0, arg8)
    }

    public fun aftermath_1<T0, T1, T2>(arg0: &mut AccessList, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T2>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg8), 1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T2, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0, 0, arg8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_access_list(arg0);
    }

    fun is_valid(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = arg0.list;
        let v1 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&v0, &v1)
    }

    fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::singleton<address>(@0x87c9e076815e78ee63b7dc225704c428b8c51072ccead4304ae07f6c68fe1b92),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun transfer_coins_with_threshold<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

