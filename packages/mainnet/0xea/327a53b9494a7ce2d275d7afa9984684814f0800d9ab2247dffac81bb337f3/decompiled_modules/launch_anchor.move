module 0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::launch_anchor {
    struct LAUNCH_ANCHOR has drop {
        dummy_field: bool,
    }

    struct LaunchAnchor has key {
        id: 0x2::object::UID,
        token_type: 0x1::type_name::TypeName,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        total_supply: u64,
        peg_mist: u64,
        virtual_sui_mist: u64,
        k: u128,
        creator: address,
        pool_id: 0x2::object::ID,
        launched_at_ms: u64,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_mint_cap(arg0: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun freeze_anchor(arg0: LaunchAnchor) {
        0x2::transfer::freeze_object<LaunchAnchor>(arg0);
    }

    fun init(arg0: LAUNCH_ANCHOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LAUNCH_ANCHOR>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x1::type_name::TypeName, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: address, arg8: 0x2::object::ID, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : LaunchAnchor {
        LaunchAnchor{
            id               : 0x2::object::new(arg10),
            token_type       : arg0,
            token_name       : arg1,
            token_symbol     : arg2,
            total_supply     : arg3,
            peg_mist         : arg4,
            virtual_sui_mist : arg5,
            k                : arg6,
            creator          : arg7,
            pool_id          : arg8,
            launched_at_ms   : arg9,
        }
    }

    // decompiled from Move bytecode v6
}

