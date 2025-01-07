module 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::tds_fee_pool_entry {
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

    public(friend) entry fun add_fee_pool_authorized_user(arg0: &mut 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::add_authorized_user(v3, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v12 = AddFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::authority::whitelist(0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::authority(v3)),
        };
        0x2::event::emit<AddFeePoolAuthorizedUserEvent>(v12);
    }

    public entry fun add_shared_fee_pool_authorized_user(arg0: &mut 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::Registry, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg3);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::add_shared_authorized_user(v3, arg1, 0x1::vector::pop_back<address>(&mut arg2));
        };
        let v12 = AddSharedFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg3),
            users  : 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::authority::whitelist(0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::shared_authority(v3, arg1)),
        };
        0x2::event::emit<AddSharedFeePoolAuthorizedUserEvent>(v12);
    }

    public(friend) entry fun remove_fee_pool_authorized_user(arg0: &mut 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::remove_authorized_user(v3, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v12 = RemoveFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::authority::whitelist(0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::authority(v3)),
        };
        0x2::event::emit<RemoveFeePoolAuthorizedUserEvent>(v12);
    }

    public entry fun remove_shared_fee_pool_authorized_user(arg0: &mut 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::Registry, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg3);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::remove_shared_authorized_user(v3, arg1, 0x1::vector::pop_back<address>(&mut arg2));
        };
        let v12 = RemoveSharedFeePoolAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg3),
            users  : 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::authority::whitelist(0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::shared_authority(v3, arg1)),
        };
        0x2::event::emit<RemoveSharedFeePoolAuthorizedUserEvent>(v12);
    }

    fun safety_check(arg0: &0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::version_check(arg0);
        0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::validate_registry_authority(arg0, arg1);
    }

    public(friend) entry fun send_fee<T0>(arg0: &mut 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::Registry, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = SendFeeEvent{
            signer    : 0x2::tx_context::sender(arg2),
            token     : 0x1::type_name::get<T0>(),
            amount    : 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::send<T0>(v3, arg1, @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba, arg2),
            recipient : @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba,
        };
        0x2::event::emit<SendFeeEvent>(v12);
    }

    public(friend) entry fun take_fee<T0>(arg0: &mut 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::Registry, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = TakeFeeEvent{
            signer : 0x2::tx_context::sender(arg2),
            token  : 0x1::type_name::get<T0>(),
            amount : 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::take<T0>(v3, arg1, arg2),
        };
        0x2::event::emit<TakeFeeEvent>(v12);
    }

    public(friend) entry fun take_shared_fee<T0>(arg0: &mut 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::Registry, arg1: vector<u8>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg3);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0x58375594d2b8c8e93530956cf7c1ab1b71d7f03ee43b6f541304dc99af4b1967::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = TakeSharedFeeEvent{
            signer : 0x2::tx_context::sender(arg3),
            key    : arg1,
            token  : 0x1::type_name::get<T0>(),
            amount : 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::take_shared<T0>(v3, arg1, arg2, arg3),
        };
        0x2::event::emit<TakeSharedFeeEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

