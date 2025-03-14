module 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian_set {
    struct GuardianSet has store {
        index: u32,
        guardians: vector<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>,
        expiration_timestamp_ms: u64,
    }

    public fun expiration_timestamp_ms(arg0: &GuardianSet) : u64 {
        arg0.expiration_timestamp_ms
    }

    public fun guardian_at(arg0: &GuardianSet, arg1: u64) : &0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian {
        0x1::vector::borrow<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>(&arg0.guardians, arg1)
    }

    public fun guardians(arg0: &GuardianSet) : &vector<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian> {
        &arg0.guardians
    }

    public fun index(arg0: &GuardianSet) : u32 {
        arg0.index
    }

    public fun index_as_u64(arg0: &GuardianSet) : u64 {
        (arg0.index as u64)
    }

    public fun is_active(arg0: &GuardianSet, arg1: &0x2::clock::Clock) : bool {
        arg0.expiration_timestamp_ms == 0 || arg0.expiration_timestamp_ms > 0x2::clock::timestamp_ms(arg1)
    }

    public fun new(arg0: u32, arg1: vector<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>) : GuardianSet {
        let v0 = 0x1::vector::length<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>(&arg1);
        let v1 = 0;
        while (v1 < v0 - 1) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::pubkey(0x1::vector::borrow<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>(&arg1, v1)) != 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::pubkey(0x1::vector::borrow<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>(&arg1, v2)), 0);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        GuardianSet{
            index                   : arg0,
            guardians               : arg1,
            expiration_timestamp_ms : 0,
        }
    }

    public fun num_guardians(arg0: &GuardianSet) : u64 {
        0x1::vector::length<0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::guardian::Guardian>(&arg0.guardians)
    }

    public fun quorum(arg0: &GuardianSet) : u64 {
        num_guardians(arg0) * 2 / 3 + 1
    }

    public(friend) fun set_expiration(arg0: &mut GuardianSet, arg1: u32, arg2: &0x2::clock::Clock) {
        arg0.expiration_timestamp_ms = 0x2::clock::timestamp_ms(arg2) + (arg1 as u64) * 1000;
    }

    // decompiled from Move bytecode v6
}

