module 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::tds_fee_pool_entry {
    struct AddFeePoolAuthorizedUserEvent has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct RemoveFeePoolAuthorizedUserEvent has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct TakeFeeEvent has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SendFeeEvent has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct AddSharedFeePoolAuthorizedUserEvent has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct RemoveSharedFeePoolAuthorizedUserEvent has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct TakeSharedFeeEvent has copy, drop {
        signer: address,
        key: vector<u8>,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) entry fun add_fee_pool_authorized_user(arg0: &mut 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::add_authorized_user(v3, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v12 = AddFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::authority(v3)),
        };
        0x2::event::emit<AddFeePoolAuthorizedUserEvent>(v12);
    }

    public entry fun add_shared_fee_pool_authorized_user(arg0: &mut 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::Registry, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg3);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::add_shared_authorized_user(v3, arg1, 0x1::vector::pop_back<address>(&mut arg2));
        };
        let v12 = AddSharedFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg3),
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::shared_authority(v3, arg1)),
        };
        0x2::event::emit<AddSharedFeePoolAuthorizedUserEvent>(v12);
    }

    public(friend) entry fun remove_fee_pool_authorized_user(arg0: &mut 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::remove_authorized_user(v3, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v12 = RemoveFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::authority(v3)),
        };
        0x2::event::emit<RemoveFeePoolAuthorizedUserEvent>(v12);
    }

    public entry fun remove_shared_fee_pool_authorized_user(arg0: &mut 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::Registry, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg3);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::remove_shared_authorized_user(v3, arg1, 0x1::vector::pop_back<address>(&mut arg2));
        };
        let v12 = RemoveSharedFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg3),
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::shared_authority(v3, arg1)),
        };
        0x2::event::emit<RemoveSharedFeePoolAuthorizedUserEvent>(v12);
    }

    fun safety_check(arg0: &0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::version_check(arg0);
        0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::validate_registry_authority(arg0, arg1);
    }

    public(friend) entry fun send_fee<T0>(arg0: &mut 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::Registry, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = SendFeeEvent{
            signer    : 0x2::tx_context::sender(arg2),
            token     : 0x1::type_name::get<T0>(),
            amount    : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::send<T0>(v3, arg1, @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9, arg2),
            recipient : @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9,
        };
        0x2::event::emit<SendFeeEvent>(v12);
    }

    public(friend) entry fun take_fee<T0>(arg0: &mut 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::Registry, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = TakeFeeEvent{
            signer : 0x2::tx_context::sender(arg2),
            token  : 0x1::type_name::get<T0>(),
            amount : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::take<T0>(v3, arg1, arg2),
        };
        0x2::event::emit<TakeFeeEvent>(v12);
    }

    entry fun take_shared_fee<T0>(arg0: &mut 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::Registry, arg1: vector<u8>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg3);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = TakeSharedFeeEvent{
            signer : 0x2::tx_context::sender(arg3),
            key    : arg1,
            token  : 0x1::type_name::get<T0>(),
            amount : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::take_shared<T0>(v3, arg1, arg2, arg3),
        };
        0x2::event::emit<TakeSharedFeeEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

