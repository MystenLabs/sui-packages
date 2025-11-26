module 0xe6c57afd3f16ffab6494943729c4a7f78bbd237bf1fe3157873d9908035e443::premium_access {
    struct AccessRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        access_list: 0x2::table::Table<vector<u8>, vector<address>>,
        content_prices: 0x2::table::Table<vector<u8>, u64>,
    }

    struct PremiumContent has store, key {
        id: 0x2::object::UID,
        content_id: vector<u8>,
        encrypted_blob_id: vector<u8>,
        owner: address,
        price: u64,
        created_at: u64,
    }

    struct ContentCreated has copy, drop {
        content_id: vector<u8>,
        owner: address,
        price: u64,
    }

    struct AccessGranted has copy, drop {
        content_id: vector<u8>,
        user: address,
        granted_by: address,
    }

    struct AccessRevoked has copy, drop {
        content_id: vector<u8>,
        user: address,
        revoked_by: address,
    }

    struct AccessPurchased has copy, drop {
        content_id: vector<u8>,
        buyer: address,
        price: u64,
    }

    public entry fun create_premium_content(arg0: &mut AccessRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 2);
        if (!0x2::table::contains<vector<u8>, vector<address>>(&arg0.access_list, arg1)) {
            0x2::table::add<vector<u8>, vector<address>>(&mut arg0.access_list, arg1, 0x1::vector::empty<address>());
        };
        if (!0x2::table::contains<vector<u8>, u64>(&arg0.content_prices, arg1)) {
            0x2::table::add<vector<u8>, u64>(&mut arg0.content_prices, arg1, arg3);
        };
        let v1 = PremiumContent{
            id                : 0x2::object::new(arg4),
            content_id        : arg1,
            encrypted_blob_id : arg2,
            owner             : v0,
            price             : arg3,
            created_at        : 0,
        };
        0x2::transfer::transfer<PremiumContent>(v1, v0);
        let v2 = ContentCreated{
            content_id : arg1,
            owner      : v0,
            price      : arg3,
        };
        0x2::event::emit<ContentCreated>(v2);
    }

    public fun get_content_price(arg0: &AccessRegistry, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.content_prices, arg1)) {
            *0x2::table::borrow<vector<u8>, u64>(&arg0.content_prices, arg1)
        } else {
            0
        }
    }

    public fun get_owner(arg0: &AccessRegistry) : address {
        arg0.owner
    }

    public entry fun grant_access(arg0: &mut AccessRegistry, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 2);
        grant_access_internal(arg0, arg1, arg2, v0);
    }

    fun grant_access_internal(arg0: &mut AccessRegistry, arg1: vector<u8>, arg2: address, arg3: address) {
        if (!0x2::table::contains<vector<u8>, vector<address>>(&arg0.access_list, arg1)) {
            0x2::table::add<vector<u8>, vector<address>>(&mut arg0.access_list, arg1, 0x1::vector::empty<address>());
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, vector<address>>(&mut arg0.access_list, arg1);
        if (!0x1::vector::contains<address>(v0, &arg2)) {
            0x1::vector::push_back<address>(v0, arg2);
            let v1 = AccessGranted{
                content_id : arg1,
                user       : arg2,
                granted_by : arg3,
            };
            0x2::event::emit<AccessGranted>(v1);
        };
    }

    public fun has_access(arg0: &AccessRegistry, arg1: vector<u8>, arg2: address) : bool {
        if (arg2 == arg0.owner) {
            return true
        };
        if (!0x2::table::contains<vector<u8>, vector<address>>(&arg0.access_list, arg1)) {
            return false
        };
        0x1::vector::contains<address>(0x2::table::borrow<vector<u8>, vector<address>>(&arg0.access_list, arg1), &arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessRegistry{
            id             : 0x2::object::new(arg0),
            owner          : 0x2::tx_context::sender(arg0),
            access_list    : 0x2::table::new<vector<u8>, vector<address>>(arg0),
            content_prices : 0x2::table::new<vector<u8>, u64>(arg0),
        };
        0x2::transfer::share_object<AccessRegistry>(v0);
    }

    public entry fun purchase_access(arg0: &mut AccessRegistry, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.content_prices, arg1), 4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 >= *0x2::table::borrow<vector<u8>, u64>(&arg0.content_prices, arg1), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.owner);
        grant_access_internal(arg0, arg1, v0, v0);
        let v2 = AccessPurchased{
            content_id : arg1,
            buyer      : v0,
            price      : v1,
        };
        0x2::event::emit<AccessPurchased>(v2);
    }

    public entry fun revoke_access(arg0: &mut AccessRegistry, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 2);
        assert!(0x2::table::contains<vector<u8>, vector<address>>(&arg0.access_list, arg1), 4);
        let v1 = 0x2::table::borrow_mut<vector<u8>, vector<address>>(&mut arg0.access_list, arg1);
        let (v2, v3) = 0x1::vector::index_of<address>(v1, &arg2);
        if (v2) {
            0x1::vector::remove<address>(v1, v3);
            let v4 = AccessRevoked{
                content_id : arg1,
                user       : arg2,
                revoked_by : v0,
            };
            0x2::event::emit<AccessRevoked>(v4);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &AccessRegistry, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg1.owner) {
            return
        };
        assert!(0x2::table::contains<vector<u8>, vector<address>>(&arg1.access_list, arg0), 4);
        assert!(0x1::vector::contains<address>(0x2::table::borrow<vector<u8>, vector<address>>(&arg1.access_list, arg0), &v0), 1);
    }

    // decompiled from Move bytecode v6
}

