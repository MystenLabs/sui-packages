module 0x9b298aeba8bdeb16c4597843fe1b4a9c644ab85dacb1abe5e75ee1843fa267be::treasury {
    struct Treasury<phantom T0: store> has key {
        id: 0x2::object::UID,
        tc: 0x2::coin::TreasuryCap<T0>,
        cooldown_volume: u64,
        last_volume_claim_timestamp: u64,
        volume_mint_val_cap: u64,
        total_minted: u64,
    }

    struct VolumeMintedEvent has copy, drop {
        sender: address,
        treasury_id: 0x2::object::ID,
        val: u64,
        total_minted: u64,
    }

    struct BoosterMintedEvent has copy, drop {
        sender: address,
        treasury_id: 0x2::object::ID,
        val: u64,
        total_minted: u64,
    }

    public fun new<T0: store>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id                          : 0x2::object::new(arg1),
            tc                          : arg0,
            cooldown_volume             : 0,
            last_volume_claim_timestamp : 0,
            volume_mint_val_cap         : 10000,
            total_minted                : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun mint_for_boosterpool<T0: store>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &0x9b298aeba8bdeb16c4597843fe1b4a9c644ab85dacb1abe5e75ee1843fa267be::admin::BoosterPoolCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x9b298aeba8bdeb16c4597843fe1b4a9c644ab85dacb1abe5e75ee1843fa267be::admin::is_booster_whitelisted(arg2, &v0), 1);
        let v1 = BoosterMintedEvent{
            sender       : 0x2::tx_context::sender(arg3),
            treasury_id  : 0x2::object::id<Treasury<T0>>(arg0),
            val          : arg1,
            total_minted : arg0.total_minted,
        };
        0x2::event::emit<BoosterMintedEvent>(v1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<T0>(&mut arg0.tc, arg1, arg3)
    }

    public fun mint_for_volume<T0: store>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &0x9b298aeba8bdeb16c4597843fe1b4a9c644ab85dacb1abe5e75ee1843fa267be::admin::VolumeCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.last_volume_claim_timestamp > arg0.cooldown_volume, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x9b298aeba8bdeb16c4597843fe1b4a9c644ab85dacb1abe5e75ee1843fa267be::admin::is_volume_whitelisted(arg2, &v0), 1);
        assert!(arg0.volume_mint_val_cap >= arg1, 2);
        arg0.last_volume_claim_timestamp = 0x2::clock::timestamp_ms(arg3);
        arg0.total_minted = arg0.total_minted + arg1;
        let v1 = VolumeMintedEvent{
            sender       : 0x2::tx_context::sender(arg4),
            treasury_id  : 0x2::object::id<Treasury<T0>>(arg0),
            val          : arg1,
            total_minted : arg0.total_minted,
        };
        0x2::event::emit<VolumeMintedEvent>(v1);
        0x2::coin::mint<T0>(&mut arg0.tc, arg1, arg4)
    }

    public fun set_volume_cooldown<T0: store>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &0x9b298aeba8bdeb16c4597843fe1b4a9c644ab85dacb1abe5e75ee1843fa267be::admin::AdminCap) {
        arg0.cooldown_volume = arg1;
    }

    // decompiled from Move bytecode v6
}

