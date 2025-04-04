module 0xde6bba29ec768f54984889ce4106b32552ef4ac365c07cee453acac84732fdbf::sbt {
    struct SoulBoundToken has key {
        id: 0x2::object::UID,
        recipient: address,
        expiry: u64,
        circuit_id: u256,
        action_id: u256,
        action_nullifier: u256,
        revoked: bool,
        minter: address,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct SBTMinted has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
        circuit_id: u256,
        action_id: u256,
        action_nullifier: u256,
        minter: address,
    }

    struct SBTRevoked has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
        minter: address,
    }

    struct MinterChanged has copy, drop {
        old_minter: address,
        new_minter: address,
    }

    public fun action_id(arg0: &SoulBoundToken) : u256 {
        arg0.action_id
    }

    public fun action_nullifier(arg0: &SoulBoundToken) : u256 {
        arg0.action_nullifier
    }

    public fun circuit_id(arg0: &SoulBoundToken) : u256 {
        arg0.circuit_id
    }

    public fun expiry(arg0: &SoulBoundToken) : u64 {
        arg0.expiry
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MinterCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &MinterCap, arg1: address, arg2: u256, arg3: u256, arg4: u256, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = SoulBoundToken{
            id               : 0x2::object::new(arg6),
            recipient        : arg1,
            expiry           : arg5,
            circuit_id       : arg2,
            action_id        : arg3,
            action_nullifier : arg4,
            revoked          : false,
            minter           : v0,
        };
        let v2 = SBTMinted{
            id               : 0x2::object::uid_to_inner(&v1.id),
            recipient        : arg1,
            circuit_id       : arg2,
            action_id        : arg3,
            action_nullifier : arg4,
            minter           : v0,
        };
        0x2::event::emit<SBTMinted>(v2);
        0x2::transfer::transfer<SoulBoundToken>(v1, arg1);
    }

    public fun minter(arg0: &SoulBoundToken) : address {
        arg0.minter
    }

    public fun recipient(arg0: &SoulBoundToken) : address {
        arg0.recipient
    }

    public entry fun revoke(arg0: &MinterCap, arg1: &mut SoulBoundToken) {
        arg1.revoked = true;
        let v0 = SBTRevoked{
            id        : 0x2::object::uid_to_inner(&arg1.id),
            recipient : arg1.recipient,
            minter    : arg1.minter,
        };
        0x2::event::emit<SBTRevoked>(v0);
    }

    public fun revoked(arg0: &SoulBoundToken) : bool {
        arg0.revoked
    }

    public entry fun set_minter(arg0: MinterCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MinterCap>(arg0, arg1);
        let v0 = MinterChanged{
            old_minter : 0x2::tx_context::sender(arg2),
            new_minter : arg1,
        };
        0x2::event::emit<MinterChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

