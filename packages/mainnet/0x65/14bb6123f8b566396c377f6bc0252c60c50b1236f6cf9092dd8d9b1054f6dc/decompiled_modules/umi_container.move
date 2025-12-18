module 0x6514bb6123f8b566396c377f6bc0252c60c50b1236f6cf9092dd8d9b1054f6dc::umi_container {
    struct UmiContainer has store, key {
        id: 0x2::object::UID,
        owner: address,
        frozen: bool,
        cap_ids: vector<0x2::object::ID>,
        next_claim_id: u64,
        claims: vector<Claim>,
    }

    struct Claim has drop, store {
        id: u64,
        cap_id: 0x2::object::ID,
        chain: u16,
        standard: u8,
        collection: vector<u8>,
        token_id: vector<u8>,
        metadata_uri_hint: vector<u8>,
    }

    struct ContainerCreated has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
    }

    struct CapDeposited has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        cap_id: 0x2::object::ID,
    }

    struct CapWithdrawn has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        cap_id: 0x2::object::ID,
        removed_claims: u64,
    }

    struct ClaimAdded has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        claim_id: u64,
        cap_id: 0x2::object::ID,
        chain: u16,
        standard: u8,
        collection: vector<u8>,
        token_id: vector<u8>,
        metadata_uri_hint: vector<u8>,
    }

    struct ClaimRemoved has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        claim_id: u64,
    }

    struct FrozenSet has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        frozen: bool,
    }

    public fun add_claim(arg0: &mut UmiContainer, arg1: 0x2::object::ID, arg2: u16, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg7);
        assert_owner(arg0, v0);
        assert!(contains_id(&arg0.cap_ids, arg1), 4);
        let v1 = arg0.next_claim_id;
        arg0.next_claim_id = arg0.next_claim_id + 1;
        let v2 = Claim{
            id                : v1,
            cap_id            : arg1,
            chain             : arg2,
            standard          : arg3,
            collection        : arg4,
            token_id          : arg5,
            metadata_uri_hint : arg6,
        };
        0x1::vector::push_back<Claim>(&mut arg0.claims, v2);
        let v3 = ClaimAdded{
            container_id      : 0x2::object::id<UmiContainer>(arg0),
            owner             : v0,
            claim_id          : v1,
            cap_id            : arg1,
            chain             : arg2,
            standard          : arg3,
            collection        : arg4,
            token_id          : arg5,
            metadata_uri_hint : arg6,
        };
        0x2::event::emit<ClaimAdded>(v3);
        v1
    }

    fun assert_owner(arg0: &UmiContainer, arg1: address) {
        assert!(arg0.owner == arg1, 0);
        assert!(!arg0.frozen, 1);
    }

    public fun cap_ids(arg0: &UmiContainer) : &vector<0x2::object::ID> {
        &arg0.cap_ids
    }

    public fun claims(arg0: &UmiContainer) : &vector<Claim> {
        &arg0.claims
    }

    public fun clear_claims(arg0: &mut UmiContainer, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0;
        while (0x1::vector::length<Claim>(&arg0.claims) > 0) {
            0x1::vector::pop_back<Claim>(&mut arg0.claims);
            v0 = v0 + 1;
        };
        v0
    }

    fun contains_id(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_container(arg0: &mut 0x2::tx_context::TxContext) : UmiContainer {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = UmiContainer{
            id            : 0x2::object::new(arg0),
            owner         : v0,
            frozen        : false,
            cap_ids       : 0x1::vector::empty<0x2::object::ID>(),
            next_claim_id : 0,
            claims        : 0x1::vector::empty<Claim>(),
        };
        let v2 = ContainerCreated{
            container_id : 0x2::object::id<UmiContainer>(&v1),
            owner        : v0,
        };
        0x2::event::emit<ContainerCreated>(v2);
        v1
    }

    public fun deposit_cap<T0: store + key>(arg0: &mut UmiContainer, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner(arg0, v0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(*0x1::type_name::borrow_string(&v1) == 0x1::ascii::string(b"0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap"), 5);
        let v2 = 0x2::object::id<T0>(&arg1);
        assert!(!contains_id(&arg0.cap_ids, v2), 2);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v2, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.cap_ids, v2);
        let v3 = CapDeposited{
            container_id : 0x2::object::id<UmiContainer>(arg0),
            owner        : v0,
            cap_id       : v2,
        };
        0x2::event::emit<CapDeposited>(v3);
    }

    public fun frozen(arg0: &UmiContainer) : bool {
        arg0.frozen
    }

    public fun owner(arg0: &UmiContainer) : address {
        arg0.owner
    }

    public fun remove_claim(arg0: &mut UmiContainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner(arg0, v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Claim>(&arg0.claims)) {
            if (0x1::vector::borrow<Claim>(&arg0.claims, v1).id == arg1) {
                0x1::vector::swap_remove<Claim>(&mut arg0.claims, v1);
                let v2 = ClaimRemoved{
                    container_id : 0x2::object::id<UmiContainer>(arg0),
                    owner        : v0,
                    claim_id     : arg1,
                };
                0x2::event::emit<ClaimRemoved>(v2);
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun remove_claims_for_cap(arg0: &mut vector<Claim>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Claim>(arg0)) {
            if (0x1::vector::borrow<Claim>(arg0, v1).cap_id == arg1) {
                0x1::vector::swap_remove<Claim>(arg0, v1);
                v0 = v0 + 1;
                continue
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun remove_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun set_frozen(arg0: &mut UmiContainer, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 0);
        arg0.frozen = arg1;
        let v1 = FrozenSet{
            container_id : 0x2::object::id<UmiContainer>(arg0),
            owner        : v0,
            frozen       : arg1,
        };
        0x2::event::emit<FrozenSet>(v1);
    }

    public fun withdraw_all<T0: store + key>(arg0: &mut UmiContainer, arg1: &mut 0x2::tx_context::TxContext) : vector<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_owner(arg0, v0);
        let v1 = 0x1::vector::empty<T0>();
        while (0x1::vector::length<0x2::object::ID>(&arg0.cap_ids) > 0) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.cap_ids);
            let v3 = &mut arg0.claims;
            remove_claims_for_cap(v3, v2);
            0x1::vector::push_back<T0>(&mut v1, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v2));
            let v4 = CapWithdrawn{
                container_id   : 0x2::object::id<UmiContainer>(arg0),
                owner          : v0,
                cap_id         : v2,
                removed_claims : 0,
            };
            0x2::event::emit<CapWithdrawn>(v4);
        };
        v1
    }

    public fun withdraw_any<T0: store + key>(arg0: &mut UmiContainer, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_owner(arg0, v0);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.cap_ids) > 0, 3);
        let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.cap_ids);
        let v2 = &mut arg0.claims;
        let v3 = CapWithdrawn{
            container_id   : 0x2::object::id<UmiContainer>(arg0),
            owner          : v0,
            cap_id         : v1,
            removed_claims : remove_claims_for_cap(v2, v1),
        };
        0x2::event::emit<CapWithdrawn>(v3);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v1)
    }

    public fun withdraw_cap<T0: store + key>(arg0: &mut UmiContainer, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner(arg0, v0);
        let v1 = &mut arg0.cap_ids;
        assert!(remove_id(v1, arg1), 3);
        let v2 = &mut arg0.claims;
        let v3 = CapWithdrawn{
            container_id   : 0x2::object::id<UmiContainer>(arg0),
            owner          : v0,
            cap_id         : arg1,
            removed_claims : remove_claims_for_cap(v2, arg1),
        };
        0x2::event::emit<CapWithdrawn>(v3);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

