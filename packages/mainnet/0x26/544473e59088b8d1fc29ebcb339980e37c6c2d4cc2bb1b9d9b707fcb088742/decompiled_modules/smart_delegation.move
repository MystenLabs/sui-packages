module 0x26544473e59088b8d1fc29ebcb339980e37c6c2d4cc2bb1b9d9b707fcb088742::smart_delegation {
    struct LinkDelegation has store, key {
        id: 0x2::object::UID,
        creator: address,
        authorized_service: address,
        total_links: u64,
        created_links: u64,
        amount_per_link: u64,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        expiry_ms: u64,
        metadata: vector<u8>,
        nonce: u64,
        max_batch_size: u64,
        allow_partial: bool,
    }

    struct ServiceRegistry has key {
        id: 0x2::object::UID,
        authorized_services: vector<address>,
        admin: address,
    }

    struct BatchReceipt has store, key {
        id: 0x2::object::UID,
        delegation_id: 0x2::object::ID,
        batch_index: u64,
        links_created: u64,
        recipients: vector<address>,
        timestamp_ms: u64,
        executor: address,
    }

    struct DelegationCreated has copy, drop {
        delegation_id: 0x2::object::ID,
        creator: address,
        service: address,
        total_links: u64,
        total_amount: u64,
        expiry_ms: u64,
    }

    struct BatchExecuted has copy, drop {
        delegation_id: 0x2::object::ID,
        batch_index: u64,
        links_created: u64,
        remaining_links: u64,
        executor: address,
    }

    struct DelegationCompleted has copy, drop {
        delegation_id: 0x2::object::ID,
        total_links_created: u64,
        unused_funds: u64,
    }

    struct DelegationRevoked has copy, drop {
        delegation_id: 0x2::object::ID,
        refunded_amount: u64,
        links_created: u64,
    }

    public fun authorize_service(arg0: &mut ServiceRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        if (!0x1::vector::contains<address>(&arg0.authorized_services, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.authorized_services, arg1);
        };
    }

    public fun complete_delegation(arg0: LinkDelegation, arg1: &mut 0x2::tx_context::TxContext) {
        let LinkDelegation {
            id                 : v0,
            creator            : v1,
            authorized_service : v2,
            total_links        : _,
            created_links      : v4,
            amount_per_link    : _,
            funds              : v6,
            expiry_ms          : _,
            metadata           : _,
            nonce              : _,
            max_batch_size     : _,
            allow_partial      : _,
        } = arg0;
        let v12 = v6;
        let v13 = v0;
        assert!(0x2::tx_context::sender(arg1) == v2 || 0x2::tx_context::sender(arg1) == v1, 0);
        let v14 = 0x2::balance::value<0x2::sui::SUI>(&v12);
        let v15 = DelegationCompleted{
            delegation_id       : 0x2::object::uid_to_inner(&v13),
            total_links_created : v4,
            unused_funds        : v14,
        };
        0x2::event::emit<DelegationCompleted>(v15);
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v12, arg1), v1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        };
        0x2::object::delete(v13);
    }

    public entry fun create_and_transfer_delegation(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<LinkDelegation>(create_delegation(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), arg1);
    }

    public fun create_configured_delegation(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : LinkDelegation {
        let v0 = create_delegation(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9);
        v0.max_batch_size = arg4;
        v0.allow_partial = arg5;
        v0
    }

    public fun create_delegation(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : LinkDelegation {
        let v0 = arg2 * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg6) + arg4 * 3600000;
        let v2 = 0x2::object::new(arg7);
        let v3 = DelegationCreated{
            delegation_id : 0x2::object::uid_to_inner(&v2),
            creator       : 0x2::tx_context::sender(arg7),
            service       : arg1,
            total_links   : arg2,
            total_amount  : v0,
            expiry_ms     : v1,
        };
        0x2::event::emit<DelegationCreated>(v3);
        LinkDelegation{
            id                 : v2,
            creator            : 0x2::tx_context::sender(arg7),
            authorized_service : arg1,
            total_links        : arg2,
            created_links      : 0,
            amount_per_link    : arg3,
            funds              : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            expiry_ms          : v1,
            metadata           : arg5,
            nonce              : 0,
            max_batch_size     : 250,
            allow_partial      : true,
        }
    }

    public fun execute_batch(arg0: &mut LinkDelegation, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : BatchReceipt {
        assert!(0x2::tx_context::sender(arg3) == arg0.authorized_service, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expiry_ms, 1);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0 && v0 <= arg0.max_batch_size, 5);
        let v1 = arg0.total_links - arg0.created_links;
        let v2 = if (v0 <= v1) {
            v0
        } else {
            assert!(arg0.allow_partial && v1 > 0, 3);
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, arg0.amount_per_link), arg3), *0x1::vector::borrow<address>(&arg1, v3));
            v3 = v3 + 1;
        };
        arg0.created_links = arg0.created_links + v2;
        arg0.nonce = arg0.nonce + 1;
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        let v5 = BatchExecuted{
            delegation_id   : v4,
            batch_index     : arg0.nonce,
            links_created   : v2,
            remaining_links : arg0.total_links - arg0.created_links,
            executor        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BatchExecuted>(v5);
        let v6 = if (v2 < v0) {
            let v7 = 0x1::vector::empty<address>();
            let v8 = 0;
            while (v8 < v2) {
                0x1::vector::push_back<address>(&mut v7, *0x1::vector::borrow<address>(&arg1, v8));
                v8 = v8 + 1;
            };
            v7
        } else {
            arg1
        };
        BatchReceipt{
            id            : 0x2::object::new(arg3),
            delegation_id : v4,
            batch_index   : arg0.nonce,
            links_created : v2,
            recipients    : v6,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
            executor      : 0x2::tx_context::sender(arg3),
        }
    }

    public fun execute_batch_optimized(arg0: &mut LinkDelegation, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg3) == arg0.authorized_service, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expiry_ms, 1);
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v0 > 0 && v0 <= arg0.max_batch_size, 5);
        let v1 = if (arg0.created_links + v0 <= arg0.total_links) {
            v0
        } else {
            arg0.total_links - arg0.created_links
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v1 * arg0.amount_per_link), arg3), arg0.authorized_service);
        arg0.created_links = arg0.created_links + v1;
        v1
    }

    public fun extend_expiry(arg0: &mut LinkDelegation, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (arg0.expiry_ms > v0) {
            arg0.expiry_ms + arg1 * 3600000
        } else {
            v0 + arg1 * 3600000
        };
        arg0.expiry_ms = v1;
    }

    public fun get_delegation_status(arg0: &LinkDelegation) : (u64, u64, u64, bool) {
        (arg0.created_links, arg0.total_links, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), arg0.created_links == arg0.total_links)
    }

    public fun get_progress_percentage(arg0: &LinkDelegation) : u64 {
        if (arg0.total_links == 0) {
            100
        } else {
            arg0.created_links * 100 / arg0.total_links
        }
    }

    public fun get_remaining_links(arg0: &LinkDelegation) : u64 {
        arg0.total_links - arg0.created_links
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ServiceRegistry{
            id                  : 0x2::object::new(arg0),
            authorized_services : 0x1::vector::empty<address>(),
            admin               : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<ServiceRegistry>(v0);
    }

    public fun is_expired(arg0: &LinkDelegation, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms
    }

    public fun remove_service(arg0: &mut ServiceRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.authorized_services, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.authorized_services, v1);
        };
    }

    public fun revoke_delegation(arg0: LinkDelegation, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.creator;
        assert!(0x2::tx_context::sender(arg1) == v0, 0);
        let v1 = DelegationRevoked{
            delegation_id   : 0x2::object::uid_to_inner(&arg0.id),
            refunded_amount : 0x2::balance::value<0x2::sui::SUI>(&arg0.funds),
            links_created   : arg0.created_links,
        };
        0x2::event::emit<DelegationRevoked>(v1);
        let LinkDelegation {
            id                 : v2,
            creator            : _,
            authorized_service : _,
            total_links        : _,
            created_links      : _,
            amount_per_link    : _,
            funds              : v8,
            expiry_ms          : _,
            metadata           : _,
            nonce              : _,
            max_batch_size     : _,
            allow_partial      : _,
        } = arg0;
        let v14 = v8;
        if (0x2::balance::value<0x2::sui::SUI>(&v14) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v14, arg1), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
        };
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

