module 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::guardian_signature {
    struct GuardianSignature has drop, store {
        r: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::Bytes32,
        s: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::Bytes32,
        recovery_id: u8,
        index: u8,
    }

    public fun index(arg0: &GuardianSignature) : u8 {
        arg0.index
    }

    public fun index_as_u64(arg0: &GuardianSignature) : u64 {
        (arg0.index as u64)
    }

    public fun new(arg0: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::Bytes32, arg1: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::Bytes32, arg2: u8, arg3: u8) : GuardianSignature {
        GuardianSignature{
            r           : arg0,
            s           : arg1,
            recovery_id : arg2,
            index       : arg3,
        }
    }

    public fun r(arg0: &GuardianSignature) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::Bytes32 {
        arg0.r
    }

    public fun recovery_id(arg0: &GuardianSignature) : u8 {
        arg0.recovery_id
    }

    public fun s(arg0: &GuardianSignature) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::Bytes32 {
        arg0.s
    }

    public fun to_rsv(arg0: GuardianSignature) : vector<u8> {
        let GuardianSignature {
            r           : v0,
            s           : v1,
            recovery_id : v2,
            index       : _,
        } = arg0;
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_bytes(v0));
        0x1::vector::append<u8>(&mut v4, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_bytes(v1));
        0x1::vector::push_back<u8>(&mut v4, v2);
        v4
    }

    // decompiled from Move bytecode v6
}

