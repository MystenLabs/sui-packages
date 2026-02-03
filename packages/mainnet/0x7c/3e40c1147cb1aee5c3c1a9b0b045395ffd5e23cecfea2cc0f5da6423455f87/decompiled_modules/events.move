module 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events {
    struct WalletPlaced has copy, drop {
        signer_id: 0x2::object::ID,
        chain_id: vector<u8>,
        wallet_id: 0x2::object::ID,
        locked: bool,
    }

    struct WalletWithdrawn has copy, drop {
        signer_id: 0x2::object::ID,
        chain_id: vector<u8>,
        wallet_id: 0x2::object::ID,
    }

    struct SigningOccurred has copy, drop {
        signer_id: 0x2::object::ID,
        chain_id: vector<u8>,
        wallet_id: 0x2::object::ID,
        intent_hash: vector<u8>,
    }

    struct SharePlaced has copy, drop {
        signer_id: 0x2::object::ID,
        chain_id: vector<u8>,
        share_id: 0x2::object::ID,
    }

    struct ShareWithdrawn has copy, drop {
        signer_id: 0x2::object::ID,
        chain_id: vector<u8>,
        share_id: 0x2::object::ID,
    }

    struct UserShareRegistered has copy, drop {
        signer_id: 0x2::object::ID,
        chain_id: vector<u8>,
        user: address,
        encrypted_share_id: 0x2::object::ID,
    }

    struct UserShareUnregistered has copy, drop {
        signer_id: 0x2::object::ID,
        chain_id: vector<u8>,
        user: address,
        encrypted_share_id: 0x2::object::ID,
    }

    public(friend) fun share_placed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: 0x2::object::ID) {
        let v0 = SharePlaced{
            signer_id : arg0,
            chain_id  : arg1,
            share_id  : arg2,
        };
        0x2::event::emit<SharePlaced>(v0);
    }

    public(friend) fun share_withdrawn(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: 0x2::object::ID) {
        let v0 = ShareWithdrawn{
            signer_id : arg0,
            chain_id  : arg1,
            share_id  : arg2,
        };
        0x2::event::emit<ShareWithdrawn>(v0);
    }

    public(friend) fun signing_occurred(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: vector<u8>) {
        let v0 = SigningOccurred{
            signer_id   : arg0,
            chain_id    : arg1,
            wallet_id   : arg2,
            intent_hash : arg3,
        };
        0x2::event::emit<SigningOccurred>(v0);
    }

    public(friend) fun user_share_registered(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: 0x2::object::ID) {
        let v0 = UserShareRegistered{
            signer_id          : arg0,
            chain_id           : arg1,
            user               : arg2,
            encrypted_share_id : arg3,
        };
        0x2::event::emit<UserShareRegistered>(v0);
    }

    public(friend) fun user_share_unregistered(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: 0x2::object::ID) {
        let v0 = UserShareUnregistered{
            signer_id          : arg0,
            chain_id           : arg1,
            user               : arg2,
            encrypted_share_id : arg3,
        };
        0x2::event::emit<UserShareUnregistered>(v0);
    }

    public(friend) fun wallet_placed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: bool) {
        let v0 = WalletPlaced{
            signer_id : arg0,
            chain_id  : arg1,
            wallet_id : arg2,
            locked    : arg3,
        };
        0x2::event::emit<WalletPlaced>(v0);
    }

    public(friend) fun wallet_withdrawn(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: 0x2::object::ID) {
        let v0 = WalletWithdrawn{
            signer_id : arg0,
            chain_id  : arg1,
            wallet_id : arg2,
        };
        0x2::event::emit<WalletWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

