module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission {
    struct Permission has store, key {
        id: 0x2::object::UID,
        permissions: 0x1::bit_vector::BitVector,
        authority: address,
        granter: address,
        grantee: address,
        created_at: u64,
        updated_at: u64,
    }

    public(friend) fun new(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Permission {
        Permission{
            id          : 0x2::object::new(arg4),
            permissions : 0x1::bit_vector::new(32),
            authority   : arg0,
            granter     : arg1,
            grantee     : arg2,
            created_at  : arg3,
            updated_at  : arg3,
        }
    }

    public(friend) fun set(arg0: &mut Permission, arg1: u64, arg2: u64) {
        0x1::bit_vector::set(&mut arg0.permissions, arg1);
        arg0.updated_at = arg2;
    }

    public(friend) fun unset(arg0: &mut Permission, arg1: u64, arg2: u64) {
        0x1::bit_vector::unset(&mut arg0.permissions, arg1);
        arg0.updated_at = arg2;
    }

    public fun PERMIT_NODE_HEARTBEAT() : u64 {
        2
    }

    public fun PERMIT_ORACLE_HEARTBEAT() : u64 {
        0
    }

    public fun PERMIT_ORACLE_QUEUE_USAGE() : u64 {
        1
    }

    public fun PERMIT_SERVICE_QUEUE_USAGE() : u64 {
        3
    }

    public fun authority(arg0: &Permission) : address {
        arg0.authority
    }

    public fun has(arg0: &Permission, arg1: u64) : bool {
        0x1::bit_vector::is_index_set(&arg0.permissions, arg1)
    }

    public fun key(arg0: &address, arg1: &address, arg2: &address) : address {
        let v0 = b"Permission";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(arg2));
        let v1 = 0x2::bcs::to_bytes<address>(arg0);
        0x1::vector::append<u8>(&mut v1, v0);
        let v2 = 0x2::bcs::new(0x1::hash::sha3_256(v1));
        0x2::bcs::peel_address(&mut v2)
    }

    public fun key_from_permission(arg0: &Permission) : address {
        key(&arg0.authority, &arg0.granter, &arg0.grantee)
    }

    // decompiled from Move bytecode v6
}

