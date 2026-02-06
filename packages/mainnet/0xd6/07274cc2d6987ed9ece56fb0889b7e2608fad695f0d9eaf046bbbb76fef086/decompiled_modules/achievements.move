module 0xd607274cc2d6987ed9ece56fb0889b7e2608fad695f0d9eaf046bbbb76fef086::achievements {
    struct Achievement has store, key {
        id: 0x2::object::UID,
        badge_type: u8,
        tier: u8,
        evm_address: vector<u8>,
        earned_at: u64,
        metadata: 0x1::string::String,
    }

    struct AchievementMinted has copy, drop {
        recipient: address,
        badge_type: u8,
        tier: u8,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    public fun badge_type(arg0: &Achievement) : u8 {
        arg0.badge_type
    }

    public fun create_minter_cap(arg0: &mut 0x2::tx_context::TxContext) : MinterCap {
        MinterCap{id: 0x2::object::new(arg0)}
    }

    public fun earned_at(arg0: &Achievement) : u64 {
        arg0.earned_at
    }

    public fun evm_address(arg0: &Achievement) : &vector<u8> {
        &arg0.evm_address
    }

    public fun metadata(arg0: &Achievement) : &0x1::string::String {
        &arg0.metadata
    }

    public fun mint(arg0: &MinterCap, arg1: address, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 4, 100);
        assert!(arg3 <= 2, 101);
        let v0 = Achievement{
            id          : 0x2::object::new(arg6),
            badge_type  : arg2,
            tier        : arg3,
            evm_address : arg4,
            earned_at   : 0x2::tx_context::epoch_timestamp_ms(arg6),
            metadata    : arg5,
        };
        0x2::transfer::transfer<Achievement>(v0, arg1);
        let v1 = AchievementMinted{
            recipient  : arg1,
            badge_type : arg2,
            tier       : arg3,
        };
        0x2::event::emit<AchievementMinted>(v1);
    }

    public fun tier(arg0: &Achievement) : u8 {
        arg0.tier
    }

    // decompiled from Move bytecode v6
}

