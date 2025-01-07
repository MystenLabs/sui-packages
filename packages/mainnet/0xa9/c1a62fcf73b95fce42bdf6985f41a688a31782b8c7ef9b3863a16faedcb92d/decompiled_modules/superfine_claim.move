module 0xa9c1a62fcf73b95fce42bdf6985f41a688a31782b8c7ef9b3863a16faedcb92d::superfine_claim {
    struct ClaimingPlatform has key {
        id: 0x2::object::UID,
        admin: address,
        operators: 0x2::vec_set::VecSet<address>,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        asset_id: 0x2::object::ID,
        owner: address,
    }

    struct EventAssetsListed has copy, drop {
        listing_ids: vector<0x2::object::ID>,
    }

    struct EventAssetDelisted has copy, drop {
        asset_id: 0x2::object::ID,
    }

    struct EventAssetsClaimed has copy, drop {
        winner: address,
    }

    public entry fun claim_asset<T0: store + key>(arg0: &mut ClaimingPlatform, arg1: vector<u8>, arg2: address, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        let v0 = pubkey_to_address(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 135289670004);
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<address>(&arg2));
        let v1 = 0x2::tx_context::sender(arg6);
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut arg1, 0x2::object::id_to_bytes(&arg3));
        0x1::vector::append<u8>(&mut arg1, arg4);
        let v2 = 0x2::hash::blake2b256(&arg1);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg4, &v2), 135289670002);
        let Listing {
            id       : v3,
            asset_id : v4,
            owner    : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3);
        assert!(arg2 == v5, 135289670001);
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v4), 0x2::tx_context::sender(arg6));
        let v6 = EventAssetsClaimed{winner: 0x2::tx_context::sender(arg6)};
        0x2::event::emit<EventAssetsClaimed>(v6);
    }

    public entry fun delist_asset<T0: store + key>(arg0: &mut ClaimingPlatform, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let Listing {
            id       : v0,
            asset_id : v1,
            owner    : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v2, 135289670000);
        let v3 = 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v1);
        let v4 = 0x2::object::id<T0>(&v3);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v3, 0x2::tx_context::sender(arg2));
        let v5 = EventAssetDelisted{asset_id: v4};
        0x2::event::emit<EventAssetDelisted>(v5);
        v4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimingPlatform{
            id        : 0x2::object::new(arg0),
            admin     : 0x2::tx_context::sender(arg0),
            operators : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<ClaimingPlatform>(v0);
    }

    public entry fun list_assets<T0: store + key>(arg0: &mut ClaimingPlatform, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::vector::length<T0>(&arg1) > 0) {
            let v1 = 0x1::vector::pop_back<T0>(&mut arg1);
            let v2 = 0x2::object::id<T0>(&v1);
            let v3 = Listing<T0>{
                id       : 0x2::object::new(arg2),
                asset_id : v2,
                owner    : 0x2::tx_context::sender(arg2),
            };
            let v4 = 0x2::object::id<Listing<T0>>(&v3);
            0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v2, v1);
            0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, v4, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v4);
        };
        0x1::vector::destroy_empty<T0>(arg1);
        let v5 = EventAssetsListed{listing_ids: v0};
        0x2::event::emit<EventAssetsListed>(v5);
        v0
    }

    fun pubkey_to_address(arg0: vector<u8>) : address {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::append<u8>(v1, arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(v1))
    }

    public entry fun set_operator(arg0: &mut ClaimingPlatform, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 135289670003);
        if (arg2) {
            if (!0x2::vec_set::contains<address>(&arg0.operators, &arg1)) {
                0x2::vec_set::insert<address>(&mut arg0.operators, arg1);
            };
        } else if (0x2::vec_set::contains<address>(&arg0.operators, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.operators, &arg1);
        };
    }

    // decompiled from Move bytecode v6
}

