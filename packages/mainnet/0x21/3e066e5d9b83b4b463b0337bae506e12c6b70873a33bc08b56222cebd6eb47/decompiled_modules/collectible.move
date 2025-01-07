module 0x213e066e5d9b83b4b463b0337bae506e12c6b70873a33bc08b56222cebd6eb47::collectible {
    struct LockProof {
        id: 0x2::object::ID,
    }

    struct MintConfig has store {
        backend_address: address,
        max_epoch: u64,
    }

    struct RedBullCollectible has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        collection: 0x1::string::String,
        tier: 0x1::string::String,
        timestamp: 0x1::string::String,
        lap_time: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct CollectibleMinted has copy, drop {
        id: 0x2::object::ID,
        receiver: address,
    }

    struct COLLECTIBLE has drop {
        dummy_field: bool,
    }

    fun get_config(arg0: &0x2::transfer_policy::TransferPolicy<RedBullCollectible>) : &MintConfig {
        0x2::dynamic_field::borrow<0x1::string::String, MintConfig>(0x2::transfer_policy::uid<RedBullCollectible>(arg0), 0x1::string::utf8(b"MINT_CONFIG"))
    }

    fun init(arg0: COLLECTIBLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<COLLECTIBLE>(arg0, arg1);
    }

    public fun install(arg0: &mut 0x2::transfer_policy::TransferPolicy<RedBullCollectible>, arg1: &0x2::transfer_policy::TransferPolicyCap<RedBullCollectible>, arg2: address, arg3: u64) {
        let v0 = MintConfig{
            backend_address : arg2,
            max_epoch       : arg3,
        };
        0x2::dynamic_field::add<0x1::string::String, MintConfig>(0x2::transfer_policy::uid_mut_as_owner<RedBullCollectible>(arg0, arg1), 0x1::string::utf8(b"MINT_CONFIG"), v0);
    }

    public fun mint_collectible(arg0: &0x2::transfer_policy::TransferPolicy<RedBullCollectible>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : (RedBullCollectible, LockProof) {
        let v0 = get_config(arg0);
        assert!(v0.backend_address == 0x2::tx_context::sender(arg9), 1);
        assert!(0x2::tx_context::epoch(arg9) <= v0.max_epoch, 2);
        let v1 = 0x2::object::new(arg9);
        let v2 = CollectibleMinted{
            id       : 0x2::object::uid_to_inner(&v1),
            receiver : arg8,
        };
        0x2::event::emit<CollectibleMinted>(v2);
        let v3 = RedBullCollectible{
            id          : v1,
            name        : arg1,
            description : arg2,
            collection  : arg3,
            tier        : arg4,
            timestamp   : arg5,
            lap_time    : arg6,
            image_url   : arg7,
        };
        let v4 = LockProof{id: 0x2::object::uid_to_inner(&v1)};
        (v3, v4)
    }

    public fun prove_locked(arg0: LockProof, arg1: &0x2::kiosk::Kiosk) {
        let LockProof { id: v0 } = arg0;
        assert!(0x2::kiosk::is_locked(arg1, v0), 3);
    }

    // decompiled from Move bytecode v6
}

