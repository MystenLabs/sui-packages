module 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_output_provenance_v5 {
    struct AnimacraftOutputProvenanceV5 has key {
        id: 0x2::object::UID,
        version: u64,
        soul_id: 0x2::object::ID,
        base_provenance_id: 0x2::object::ID,
        maker_root_id: 0x2::object::ID,
        complete_output_seal_id: vector<u8>,
    }

    struct AnimacraftOutputProvenanceV5Created has copy, drop {
        output_provenance_id: 0x2::object::ID,
        base_provenance_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        maker_root_id: 0x2::object::ID,
        complete_output_seal_id: vector<u8>,
    }

    public fun assert_matches_root(arg0: &AnimacraftOutputProvenanceV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5) {
        assert!(arg0.maker_root_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1), 1);
    }

    public fun assert_matches_soul(arg0: &AnimacraftOutputProvenanceV5, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState) {
        assert!(arg0.soul_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg1), 0);
        assert!(0x2::object::id<AnimacraftOutputProvenanceV5>(arg0) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::animacraft_output_provenance_v5_id(arg1), 0);
        assert!(arg0.base_provenance_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::animacraft_provenance_id(arg1), 2);
    }

    public fun base_provenance_id(arg0: &AnimacraftOutputProvenanceV5) : 0x2::object::ID {
        arg0.base_provenance_id
    }

    public fun maker_root_id(arg0: &AnimacraftOutputProvenanceV5) : 0x2::object::ID {
        arg0.maker_root_id
    }

    public(friend) fun new_bind_and_freeze(arg0: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        let v0 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg0);
        let v1 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::animacraft_provenance_id(arg0);
        let v2 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1);
        let v3 = AnimacraftOutputProvenanceV5{
            id                      : 0x2::object::new(arg3),
            version                 : 1,
            soul_id                 : v0,
            base_provenance_id      : v1,
            maker_root_id           : v2,
            complete_output_seal_id : arg2,
        };
        let v4 = 0x2::object::id<AnimacraftOutputProvenanceV5>(&v3);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::bind_animacraft_output_provenance_v5(arg0, v4);
        let v5 = AnimacraftOutputProvenanceV5Created{
            output_provenance_id    : v4,
            base_provenance_id      : v1,
            soul_id                 : v0,
            state_id                : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg0),
            maker_root_id           : v2,
            complete_output_seal_id : *output_seal_id(&v3),
        };
        0x2::event::emit<AnimacraftOutputProvenanceV5Created>(v5);
        0x2::transfer::freeze_object<AnimacraftOutputProvenanceV5>(v3);
    }

    public fun output_seal_id(arg0: &AnimacraftOutputProvenanceV5) : &vector<u8> {
        &arg0.complete_output_seal_id
    }

    public fun provenance_id(arg0: &AnimacraftOutputProvenanceV5) : 0x2::object::ID {
        0x2::object::id<AnimacraftOutputProvenanceV5>(arg0)
    }

    public fun soul_id(arg0: &AnimacraftOutputProvenanceV5) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun version(arg0: &AnimacraftOutputProvenanceV5) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

