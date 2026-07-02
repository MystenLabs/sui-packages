module 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::session_cap {
    struct SessionCap has key {
        id: 0x2::object::UID,
        player: address,
        account_id: 0x2::object::ID,
        session_pubkey: vector<u8>,
        nonce: u64,
        expires_at: u64,
        revoked: bool,
    }

    struct SessionCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
        player: address,
        account_id: 0x2::object::ID,
        session_pubkey: vector<u8>,
        nonce: u64,
        expires_at: u64,
    }

    struct SessionCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        player: address,
        revoked_at: u64,
    }

    public fun account_id(arg0: &SessionCap) : 0x2::object::ID {
        arg0.account_id
    }

    public fun create_session_cap(arg0: &mut 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::PlayerAccount, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::owner(arg0) == v0, 200);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 201);
        assert!(arg2 >= 60000 && arg2 <= 86400000, 202);
        let v1 = 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::next_session_nonce(arg0, arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3) + arg2;
        let v3 = SessionCap{
            id             : 0x2::object::new(arg4),
            player         : v0,
            account_id     : 0x2::object::id<0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::PlayerAccount>(arg0),
            session_pubkey : arg1,
            nonce          : v1,
            expires_at     : v2,
            revoked        : false,
        };
        let v4 = SessionCapCreated{
            cap_id         : 0x2::object::id<SessionCap>(&v3),
            player         : v0,
            account_id     : 0x2::object::id<0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::PlayerAccount>(arg0),
            session_pubkey : v3.session_pubkey,
            nonce          : v1,
            expires_at     : v2,
        };
        0x2::event::emit<SessionCapCreated>(v4);
        0x2::transfer::transfer<SessionCap>(v3, v0);
    }

    public fun expires_at(arg0: &SessionCap) : u64 {
        arg0.expires_at
    }

    public fun is_active(arg0: &SessionCap, arg1: u64) : bool {
        !arg0.revoked && arg0.expires_at > arg1
    }

    public fun nonce(arg0: &SessionCap) : u64 {
        arg0.nonce
    }

    public fun player(arg0: &SessionCap) : address {
        arg0.player
    }

    public fun pubkey(arg0: &SessionCap) : &vector<u8> {
        &arg0.session_pubkey
    }

    public fun revoke_session_cap(arg0: &mut SessionCap, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg2), 200);
        assert!(!arg0.revoked, 203);
        arg0.revoked = true;
        let v0 = SessionCapRevoked{
            cap_id     : 0x2::object::id<SessionCap>(arg0),
            player     : arg0.player,
            revoked_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SessionCapRevoked>(v0);
    }

    public fun revoked(arg0: &SessionCap) : bool {
        arg0.revoked
    }

    // decompiled from Move bytecode v7
}

