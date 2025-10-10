module 0xe80557d7f9b6cce827716c9f8ad1c6e34c95aae564847b223e0e163a64fd1317::operators {
    struct MultiMinter has key {
        id: 0x2::object::UID,
        distributor_cap: 0x1::option::Option<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel>,
        operator_cap: 0x1::option::Option<0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::OperatorCap>,
        distributor_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_distributor_cap(arg0: &mut MultiMinter, arg1: &OwnerCap, arg2: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel) {
        0x1::option::fill<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel>(&mut arg0.distributor_cap, arg2);
    }

    public fun add_operator_cap(arg0: &mut MultiMinter, arg1: &OwnerCap, arg2: 0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::OperatorCap, arg3: 0x2::object::ID) {
        0x1::option::fill<0x2::object::ID>(&mut arg0.distributor_cap_id, arg3);
        0x1::option::fill<0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::OperatorCap>(&mut arg0.operator_cap, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MultiMinter{
            id                 : 0x2::object::new(arg0),
            distributor_cap    : 0x1::option::none<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel>(),
            operator_cap       : 0x1::option::none<0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::OperatorCap>(),
            distributor_cap_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<MultiMinter>(v0);
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint<T0>(arg0: &MultiMinter, arg1: &mut 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service::InterchainTokenService, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service::mint_as_distributor<T0>(arg1, 0x1::option::borrow<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel>(&arg0.distributor_cap), arg2, arg3, arg4)
    }

    public fun mint_as_operator<T0>(arg0: &mut MultiMinter, arg1: &mut 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service::InterchainTokenService, arg2: &mut 0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::Operators, arg3: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::loan_cap<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel>(arg2, 0x1::option::borrow<0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::OperatorCap>(&arg0.operator_cap), *0x1::option::borrow<0x2::object::ID>(&arg0.distributor_cap_id), arg5);
        let v2 = v0;
        0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::restore_cap<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel>(arg2, 0x1::option::borrow<0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::OperatorCap>(&arg0.operator_cap), v2, v1);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service::mint_as_distributor<T0>(arg1, &v2, arg3, arg4, arg5)
    }

    public fun remove_distributor_cap(arg0: &mut MultiMinter, arg1: &OwnerCap) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel {
        0x1::option::extract<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel>(&mut arg0.distributor_cap)
    }

    public fun remove_operator_cap(arg0: &mut MultiMinter, arg1: &OwnerCap) : 0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::OperatorCap {
        0x1::option::extract<0x2::object::ID>(&mut arg0.distributor_cap_id);
        0x1::option::extract<0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators::OperatorCap>(&mut arg0.operator_cap)
    }

    // decompiled from Move bytecode v6
}

