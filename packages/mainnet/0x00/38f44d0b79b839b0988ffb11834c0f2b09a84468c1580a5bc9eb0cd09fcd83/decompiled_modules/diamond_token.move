module 0x38f44d0b79b839b0988ffb11834c0f2b09a84468c1580a5bc9eb0cd09fcd83::diamond_token {
    struct DIAMOND_TOKEN has drop {
        dummy_field: bool,
    }

    struct DiamondTreasury has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<DIAMOND_TOKEN>,
        total_minted_rewards: u64,
        admin: address,
    }

    struct DiamondAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun total_supply(arg0: &DiamondTreasury) : u64 {
        0x2::coin::total_supply<DIAMOND_TOKEN>(&arg0.treasury_cap)
    }

    public fun admin_mint(arg0: &DiamondAdminCap, arg1: &mut DiamondTreasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.total_minted_rewards = arg1.total_minted_rewards + arg2;
        0x2::coin::mint_and_transfer<DIAMOND_TOKEN>(&mut arg1.treasury_cap, arg2, arg3, arg4);
    }

    fun init(arg0: DIAMOND_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMOND_TOKEN>(arg0, 9, b"DIAMOND", b"Soyara Diamond Token", b"Official Reward & Governance Token earned by staking Soyara Genesis Pass. Earn 10 Diamond per day per pass.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmZq8H7bY5n2bX9J1V4Q3W8G6L2k9p7R1Y3w5Z6x7y8z9a")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMOND_TOKEN>>(v1);
        let v2 = DiamondTreasury{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v0,
            total_minted_rewards : 0,
            admin                : 0x2::tx_context::sender(arg1),
        };
        let v3 = DiamondAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<DiamondTreasury>(v2);
        0x2::transfer::public_transfer<DiamondAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_reward(arg0: &mut DiamondTreasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        arg0.total_minted_rewards = arg0.total_minted_rewards + arg1;
        0x2::coin::mint_and_transfer<DIAMOND_TOKEN>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    public fun set_admin(arg0: &DiamondAdminCap, arg1: &mut DiamondTreasury, arg2: address) {
        arg1.admin = arg2;
    }

    public fun total_minted_rewards(arg0: &DiamondTreasury) : u64 {
        arg0.total_minted_rewards
    }

    // decompiled from Move bytecode v7
}

