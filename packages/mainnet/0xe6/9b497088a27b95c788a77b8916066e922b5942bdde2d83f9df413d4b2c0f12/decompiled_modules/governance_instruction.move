module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction {
    struct GovernanceInstruction {
        module_: u8,
        action: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::GovernanceAction,
        target_chain_id: u64,
        payload: vector<u8>,
    }

    public fun destroy(arg0: GovernanceInstruction) : vector<u8> {
        let GovernanceInstruction {
            module_         : _,
            action          : _,
            target_chain_id : _,
            payload         : v3,
        } = arg0;
        v3
    }

    public fun from_byte_vec(arg0: vector<u8>) : GovernanceInstruction {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_vector(&mut v0, 4) == b"PTGM", 1);
        let v1 = GovernanceInstruction{
            module_         : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u8(&mut v0),
            action          : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::from_u8(0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u8(&mut v0)),
            target_chain_id : (0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u16(&mut v0) as u64),
            payload         : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0),
        };
        validate(&v1);
        v1
    }

    public fun get_action(arg0: &GovernanceInstruction) : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::GovernanceAction {
        arg0.action
    }

    public fun get_module(arg0: &GovernanceInstruction) : u8 {
        arg0.module_
    }

    public fun get_target_chain_id(arg0: &GovernanceInstruction) : u64 {
        arg0.target_chain_id
    }

    fun validate(arg0: &GovernanceInstruction) {
        assert!(arg0.module_ == 1, 0);
        let v0 = arg0.target_chain_id;
        assert!(v0 == (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id() as u64) || v0 == 0, 2);
    }

    // decompiled from Move bytecode v6
}

