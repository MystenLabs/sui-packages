module 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    struct EggCollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<AfEgg>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<AfEgg>,
        max_supply: u32,
        minted: u32,
    }

    struct AfEgg has store, key {
        id: 0x2::object::UID,
    }

    public fun display(arg0: &EggCollectionInfo) : &0x2::display::Display<AfEgg> {
        &arg0.display
    }

    public fun add_kiosk_lock_rule(arg0: &EggCollectionInfo, arg1: &mut 0x2::transfer_policy::TransferPolicy<AfEgg>) {
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::kiosk_lock_rule::add<AfEgg>(arg1, &arg0.policy_cap);
    }

    public fun batch_mint(arg0: &mut EggCollectionInfo, arg1: &mut 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::MintedEggsEventMetadata, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : vector<AfEgg> {
        assert!(arg0.minted + arg2 < arg0.max_supply, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors::max_supply_reached());
        arg0.minted = arg0.minted + arg2;
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::add_minted_amount(arg1, arg2);
        let v0 = 0x1::vector::empty<AfEgg>();
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = AfEgg{id: 0x2::object::new(arg3)};
            0x1::vector::push_back<AfEgg>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun batch_mint_and_keep(arg0: &mut EggCollectionInfo, arg1: &mut 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::MintedEggsEventMetadata, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted + arg2 < arg0.max_supply, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors::max_supply_reached());
        arg0.minted = arg0.minted + arg2;
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::add_minted_amount(arg1, arg2);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = AfEgg{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<AfEgg>(v1, 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
        };
    }

    public fun begin_mint() : 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::MintedEggsEventMetadata {
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::begin_mint()
    }

    public fun creator() : vector<u8> {
        b"Aftermath Finance"
    }

    public fun description() : vector<u8> {
        x"f09fa59a"
    }

    public fun end_mint(arg0: 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::MintedEggsEventMetadata) {
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::emit_minted_eggs(arg0);
    }

    public fun image_url() : vector<u8> {
        b"https://bafybeibhwaakw2mqgchdbpao2neb3wkvhnbvw2hcscl5njkj3c7hdouer4.ipfs.cf-ipfs.com/"
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EGG>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Egg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://bafybeibhwaakw2mqgchdbpao2neb3wkvhnbvw2hcscl5njkj3c7hdouer4.ipfs.cf-ipfs.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"f09fa59a"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aftermath.finance"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Aftermath Finance"));
        let v5 = 0x2::display::new_with_fields<AfEgg>(&v0, v1, v3, arg1);
        0x2::display::update_version<AfEgg>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<AfEgg>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::royalty_rule::add<AfEgg>(&mut v9, &v8, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::constants::amount_bps(), 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<AfEgg>>(v9);
        let v10 = EggCollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v0,
            display    : v5,
            policy_cap : v8,
            max_supply : 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::constants::max_supply(),
            minted     : 0,
        };
        0x2::transfer::public_transfer<EggCollectionInfo>(v10, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut EggCollectionInfo, arg1: &mut 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::MintedEggsEventMetadata, arg2: &mut 0x2::tx_context::TxContext) : AfEgg {
        assert!(arg0.minted < arg0.max_supply, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors::max_supply_reached());
        arg0.minted = arg0.minted + 1;
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::add_minted_amount(arg1, 1);
        AfEgg{id: 0x2::object::new(arg2)}
    }

    public fun mint_and_keep(arg0: &mut EggCollectionInfo, arg1: &mut 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::MintedEggsEventMetadata, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2);
        0x2::transfer::public_transfer<AfEgg>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun name() : vector<u8> {
        b"Egg"
    }

    public fun project_url() : vector<u8> {
        b"https://aftermath.finance"
    }

    public fun publisher(arg0: &EggCollectionInfo) : &0x2::package::Publisher {
        &arg0.publisher
    }

    public fun transfer_policy_cap(arg0: &EggCollectionInfo) : &0x2::transfer_policy::TransferPolicyCap<AfEgg> {
        &arg0.policy_cap
    }

    // decompiled from Move bytecode v6
}

