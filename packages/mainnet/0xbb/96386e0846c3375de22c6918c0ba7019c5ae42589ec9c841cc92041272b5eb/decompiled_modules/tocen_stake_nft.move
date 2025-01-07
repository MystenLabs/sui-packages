module 0xbb96386e0846c3375de22c6918c0ba7019c5ae42589ec9c841cc92041272b5eb::tocen_stake_nft {
    struct ShareObjectStake has key {
        id: 0x2::object::UID,
        nft_key_stake: u64,
        type_key: 0x1::ascii::String,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        owner_stake: address,
        type_nft_stake: 0x1::type_name::TypeName,
    }

    struct EventStakeNFT has copy, drop {
        share_object_id: 0x2::object::ID,
        type_nft_stake: 0x1::type_name::TypeName,
        owner_stake: address,
        nft_depsoit: 0x2::object::ID,
    }

    struct EventClaimNFT has copy, drop {
        share_object_id_claim: 0x2::object::ID,
        type_nft_stake: 0x1::type_name::TypeName,
        owner_stake: address,
        nft_claim: 0x2::object::ID,
    }

    public entry fun Deposit<T0: store + key>(arg0: &mut ShareObjectStake, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        if (0x1::type_name::into_string(v0) == arg0.type_key) {
            arg0.nft_key_stake = arg0.nft_key_stake + 1;
        };
        let v3 = Listing{
            id             : 0x2::object::new(arg2),
            owner_stake    : v2,
            type_nft_stake : v0,
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v3.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v1, v3);
        let v4 = EventStakeNFT{
            share_object_id : 0x2::object::id<ShareObjectStake>(arg0),
            type_nft_stake  : v0,
            owner_stake     : v2,
            nft_depsoit     : v1,
        };
        0x2::event::emit<EventStakeNFT>(v4);
    }

    public entry fun UnStaking<T0: store + key>(arg0: &mut ShareObjectStake, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = claim<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v1, v0);
        if (0x1::type_name::into_string(0x1::type_name::get<T0>()) == arg0.type_key) {
            arg0.nft_key_stake = arg0.nft_key_stake - 1;
        };
        let v2 = EventClaimNFT{
            share_object_id_claim : 0x2::object::id<ShareObjectStake>(arg0),
            type_nft_stake        : 0x1::type_name::get<T0>(),
            owner_stake           : v0,
            nft_claim             : arg1,
        };
        0x2::event::emit<EventClaimNFT>(v2);
    }

    public fun claim<T0: store + key>(arg0: &mut ShareObjectStake, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id             : v0,
            owner_stake    : v1,
            type_nft_stake : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 1);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareObjectStake{
            id            : 0x2::object::new(arg0),
            nft_key_stake : 0,
            type_key      : 0x1::ascii::string(0xbb96386e0846c3375de22c6918c0ba7019c5ae42589ec9c841cc92041272b5eb::utils::get_nft()),
        };
        0x2::transfer::share_object<ShareObjectStake>(v0);
    }

    public entry fun type_key<T0: store + key>(arg0: &mut ShareObjectStake, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb96386e0846c3375de22c6918c0ba7019c5ae42589ec9c841cc92041272b5eb::witness::check_owner(arg1), 1);
        arg0.type_key = 0x1::type_name::into_string(0x1::type_name::get<T0>());
    }

    // decompiled from Move bytecode v6
}

