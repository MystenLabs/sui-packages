module 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance {
    struct AnimacraftProvenance has key {
        id: 0x2::object::UID,
        version: u64,
        soul_id: 0x2::object::ID,
        animacraft_version: u64,
        maker_id: 0x2::object::ID,
        maker_treasury_id: 0x2::object::ID,
        maker_creator: address,
        payer: address,
        profile_json_blob_id: 0x1::string::String,
        image_blob_id: 0x1::string::String,
        image_url: 0x1::string::String,
        recipe_hash: vector<u8>,
        license_snapshot: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::LicensePolicy,
        royalty_policy: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RoyaltyPolicySnapshot,
        mint_payment_coin_type: 0x1::string::String,
        mint_price_atomic: u64,
        protocol_fee_config_id: 0x2::object::ID,
        protocol_treasury_id: 0x2::object::ID,
        primary_protocol_fee_bps: u16,
        primary_protocol_fee_atomic: u64,
        recipe: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>,
        authorized_at_ms: u64,
    }

    struct AnimacraftProvenanceCreated has copy, drop {
        provenance_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        maker_id: 0x2::object::ID,
        maker_treasury_id: 0x2::object::ID,
        payer: address,
        royalty_bps: u16,
        protocol_fee_config_id: 0x2::object::ID,
        protocol_treasury_id: 0x2::object::ID,
        primary_protocol_fee_bps: u16,
        primary_protocol_fee_atomic: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: address, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<u8>, arg10: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::LicensePolicy, arg11: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RoyaltyPolicySnapshot, arg12: 0x1::string::String, arg13: u64, arg14: 0x2::object::ID, arg15: 0x2::object::ID, arg16: u16, arg17: u64, arg18: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) : AnimacraftProvenance {
        AnimacraftProvenance{
            id                          : 0x2::object::new(arg20),
            version                     : 1,
            soul_id                     : arg0,
            animacraft_version          : arg1,
            maker_id                    : arg2,
            maker_treasury_id           : arg3,
            maker_creator               : arg4,
            payer                       : arg5,
            profile_json_blob_id        : arg6,
            image_blob_id               : arg7,
            image_url                   : arg8,
            recipe_hash                 : arg9,
            license_snapshot            : arg10,
            royalty_policy              : arg11,
            mint_payment_coin_type      : arg12,
            mint_price_atomic           : arg13,
            protocol_fee_config_id      : arg14,
            protocol_treasury_id        : arg15,
            primary_protocol_fee_bps    : arg16,
            primary_protocol_fee_atomic : arg17,
            recipe                      : arg18,
            authorized_at_ms            : arg19,
        }
    }

    public fun maker_id(arg0: &AnimacraftProvenance) : 0x2::object::ID {
        arg0.maker_id
    }

    public fun animacraft_version(arg0: &AnimacraftProvenance) : u64 {
        arg0.animacraft_version
    }

    public(friend) fun assert_matches_maker<T0>(arg0: &AnimacraftProvenance, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<T0>) {
        assert!(arg0.maker_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_id(arg1), 1);
        assert!(arg0.maker_treasury_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::treasury_id<T0>(arg2), 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::treasury_maker_id<T0>(arg2) == arg0.maker_id, 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::royalty_policy_maker_id(&arg0.royalty_policy) == arg0.maker_id, 1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::royalty_policy_treasury_id(&arg0.royalty_policy) == arg0.maker_treasury_id, 2);
    }

    public(friend) fun assert_matches_soul(arg0: &AnimacraftProvenance, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState) {
        assert!(arg0.soul_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg1), 0);
        assert!(0x2::object::id<AnimacraftProvenance>(arg0) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::animacraft_provenance_id(arg1), 0);
    }

    public fun authorized_at_ms(arg0: &AnimacraftProvenance) : u64 {
        arg0.authorized_at_ms
    }

    public(friend) fun bind_and_freeze(arg0: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: AnimacraftProvenance) {
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg0) == arg1.soul_id, 0);
        let v0 = 0x2::object::id<AnimacraftProvenance>(&arg1);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::bind_animacraft_provenance(arg0, v0);
        let v1 = AnimacraftProvenanceCreated{
            provenance_id               : v0,
            soul_id                     : arg1.soul_id,
            state_id                    : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg0),
            maker_id                    : arg1.maker_id,
            maker_treasury_id           : arg1.maker_treasury_id,
            payer                       : arg1.payer,
            royalty_bps                 : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::royalty_policy_bps(&arg1.royalty_policy),
            protocol_fee_config_id      : arg1.protocol_fee_config_id,
            protocol_treasury_id        : arg1.protocol_treasury_id,
            primary_protocol_fee_bps    : arg1.primary_protocol_fee_bps,
            primary_protocol_fee_atomic : arg1.primary_protocol_fee_atomic,
        };
        0x2::event::emit<AnimacraftProvenanceCreated>(v1);
        0x2::transfer::freeze_object<AnimacraftProvenance>(arg1);
    }

    public fun image_blob_id(arg0: &AnimacraftProvenance) : &0x1::string::String {
        &arg0.image_blob_id
    }

    public fun image_url(arg0: &AnimacraftProvenance) : &0x1::string::String {
        &arg0.image_url
    }

    public fun is_v4_compatible(arg0: &AnimacraftProvenance) : bool {
        arg0.animacraft_version == 4
    }

    public fun is_v5_commerce_compatible(arg0: &AnimacraftProvenance) : bool {
        arg0.animacraft_version == 5
    }

    public fun license_snapshot(arg0: &AnimacraftProvenance) : &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::LicensePolicy {
        &arg0.license_snapshot
    }

    public fun maker_creator(arg0: &AnimacraftProvenance) : address {
        arg0.maker_creator
    }

    public fun maker_treasury_id(arg0: &AnimacraftProvenance) : 0x2::object::ID {
        arg0.maker_treasury_id
    }

    public fun mint_payment_coin_type(arg0: &AnimacraftProvenance) : &0x1::string::String {
        &arg0.mint_payment_coin_type
    }

    public fun mint_price_atomic(arg0: &AnimacraftProvenance) : u64 {
        arg0.mint_price_atomic
    }

    public fun payer(arg0: &AnimacraftProvenance) : address {
        arg0.payer
    }

    public fun primary_protocol_fee_atomic(arg0: &AnimacraftProvenance) : u64 {
        arg0.primary_protocol_fee_atomic
    }

    public fun primary_protocol_fee_bps(arg0: &AnimacraftProvenance) : u16 {
        arg0.primary_protocol_fee_bps
    }

    public fun profile_json_blob_id(arg0: &AnimacraftProvenance) : &0x1::string::String {
        &arg0.profile_json_blob_id
    }

    public fun protocol_fee_config_id(arg0: &AnimacraftProvenance) : 0x2::object::ID {
        arg0.protocol_fee_config_id
    }

    public fun protocol_treasury_id(arg0: &AnimacraftProvenance) : 0x2::object::ID {
        arg0.protocol_treasury_id
    }

    public fun provenance_id(arg0: &AnimacraftProvenance) : 0x2::object::ID {
        0x2::object::id<AnimacraftProvenance>(arg0)
    }

    public fun recipe(arg0: &AnimacraftProvenance) : &vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot> {
        &arg0.recipe
    }

    public fun recipe_hash(arg0: &AnimacraftProvenance) : &vector<u8> {
        &arg0.recipe_hash
    }

    public fun royalty_bps(arg0: &AnimacraftProvenance) : u16 {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::royalty_policy_bps(&arg0.royalty_policy)
    }

    public fun royalty_policy(arg0: &AnimacraftProvenance) : &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RoyaltyPolicySnapshot {
        &arg0.royalty_policy
    }

    public fun soul_id(arg0: &AnimacraftProvenance) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun version(arg0: &AnimacraftProvenance) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

