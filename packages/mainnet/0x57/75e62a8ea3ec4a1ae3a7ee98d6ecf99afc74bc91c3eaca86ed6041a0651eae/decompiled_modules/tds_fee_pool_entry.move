module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_fee_pool_entry {
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

    public(friend) entry fun add_fee_pool_authorized_user(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::add_authorized_user(v3, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v12 = AddFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::authority(v3)),
        };
        0x2::event::emit<AddFeePoolAuthorizedUserEvent>(v12);
    }

    public fun add_shared_fee_pool_authorized_user(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) entry fun remove_fee_pool_authorized_user(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::remove_authorized_user(v3, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v12 = RemoveFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::authority(v3)),
        };
        0x2::event::emit<RemoveFeePoolAuthorizedUserEvent>(v12);
    }

    public fun remove_shared_fee_pool_authorized_user(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    fun safety_check(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_registry_authority(arg0, arg1);
    }

    public(friend) entry fun send_fee<T0>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = SendFeeEvent{
            signer    : 0x2::tx_context::sender(arg2),
            token     : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::send<T0>(v3, arg1, @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9, arg2),
            recipient : @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9,
        };
        0x2::event::emit<SendFeeEvent>(v12);
    }

    public(friend) entry fun take_fee<T0>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = TakeFeeEvent{
            signer : 0x2::tx_context::sender(arg2),
            token  : 0x1::type_name::with_defining_ids<T0>(),
            amount : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::take<T0>(v3, arg1, arg2),
        };
        0x2::event::emit<TakeFeeEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

