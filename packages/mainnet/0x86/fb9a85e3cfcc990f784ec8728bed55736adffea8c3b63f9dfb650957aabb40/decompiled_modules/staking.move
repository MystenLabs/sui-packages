module 0x86fb9a85e3cfcc990f784ec8728bed55736adffea8c3b63f9dfb650957aabb40::staking {
    struct HominidsVault<phantom T0, phantom T1: store + key> has key {
        id: 0x2::object::UID,
        owner: address,
        staked_hominids: u64,
        common_dpr: u64,
        rare_dpr: u64,
        epic_dpr: u64,
        legendary_dpr: u64,
        rewards: 0x2::balance::Balance<T0>,
        rarities: 0x2::table::Table<0x2::object::ID, u8>,
        withdrawn_rewards: u64,
    }

    struct StakeReceipt has key {
        id: 0x2::object::UID,
        nft_id: address,
        rarity: 0x1::string::String,
        stakedAt: u64,
        withdrawn_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct STAKING has drop {
        dummy_field: bool,
    }

    public entry fun add_rarity<T0, T1: store + key>(arg0: &mut HominidsVault<T0, T1>, arg1: 0x2::object::ID, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(arg2 == 0 || arg2 == 1 || arg2 == 2 || arg2 == 3, 0);
        if (0x2::table::contains<0x2::object::ID, u8>(&arg0.rarities, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, u8>(&mut arg0.rarities, arg1) = arg2;
        } else {
            0x2::table::add<0x2::object::ID, u8>(&mut arg0.rarities, arg1, arg2);
        };
    }

    public entry fun claim_rewards<T0, T1: store + key>(arg0: &mut HominidsVault<T0, T1>, arg1: &mut StakeReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.rarity;
        let v1 = 0;
        if (v0 == 0x1::string::utf8(b"Common")) {
            v1 = (0x2::clock::timestamp_ms(arg2) - arg1.stakedAt) * arg0.common_dpr / 86400 * 1000000;
        } else if (v0 == 0x1::string::utf8(b"Rare")) {
            v1 = (0x2::clock::timestamp_ms(arg2) - arg1.stakedAt) * arg0.rare_dpr / 86400 * 1000000;
        } else if (v0 == 0x1::string::utf8(b"Epic")) {
            v1 = (0x2::clock::timestamp_ms(arg2) - arg1.stakedAt) * arg0.epic_dpr / 86400 * 1000000;
        } else if (v0 == 0x1::string::utf8(b"Legendary")) {
            v1 = (0x2::clock::timestamp_ms(arg2) - arg1.stakedAt) * arg0.legendary_dpr / 86400 * 1000000;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.rewards, v1 - arg1.withdrawn_amount, arg3), 0x2::tx_context::sender(arg3));
        arg0.withdrawn_rewards = arg0.withdrawn_rewards + v1 - arg1.withdrawn_amount;
        arg1.withdrawn_amount = v1;
    }

    public entry fun create_vault<T0, T1: store + key>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let v0 = HominidsVault<T0, T1>{
            id                : 0x2::object::new(arg1),
            owner             : 0x2::tx_context::sender(arg1),
            staked_hominids   : 0,
            common_dpr        : 10,
            rare_dpr          : 20,
            epic_dpr          : 50,
            legendary_dpr     : 100,
            rewards           : 0x2::balance::zero<T0>(),
            rarities          : 0x2::table::new<0x2::object::ID, u8>(arg1),
            withdrawn_rewards : 0,
        };
        0x2::transfer::share_object<HominidsVault<T0, T1>>(v0);
    }

    public entry fun deposit_rewards<T0, T1: store + key>(arg0: &mut HominidsVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::coin::put<T0>(&mut arg0.rewards, arg1);
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Staked hominid receipt"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://era-homi.xyz/nft/{nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://hominids.io/hominids_ipfs/staking/{rarity}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A receipt NFT which prove that you are staking a Hominid NFT."));
        let v4 = 0x2::package::claim<STAKING>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<StakeReceipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<StakeReceipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<StakeReceipt>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun rotate_owner<T0, T1: store + key>(arg0: &mut HominidsVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        arg0.owner = 0x2::tx_context::sender(arg1);
    }

    public entry fun stake<T0, T1: store + key>(arg0: &mut HominidsVault<T0, T1>, arg1: T1, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Common"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Rare"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Epic"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Legendary"));
        let v2 = 0x2::object::id_address<T1>(&mut arg1);
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut arg0.id, 0x2::address::to_bytes(v2), arg1);
        let v3 = StakeReceipt{
            id               : 0x2::object::new(arg3),
            nft_id           : v2,
            rarity           : *0x1::vector::borrow<0x1::string::String>(&v0, (*0x2::table::borrow<0x2::object::ID, u8>(&mut arg0.rarities, 0x2::object::id<T1>(&arg1)) as u64)),
            stakedAt         : 0x2::clock::timestamp_ms(arg2),
            withdrawn_amount : 0,
        };
        0x2::transfer::transfer<StakeReceipt>(v3, 0x2::tx_context::sender(arg3));
        arg0.staked_hominids = arg0.staked_hominids + 1;
    }

    public entry fun unstake<T0, T1: store + key>(arg0: &mut HominidsVault<T0, T1>, arg1: StakeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let StakeReceipt {
            id               : v0,
            nft_id           : v1,
            rarity           : _,
            stakedAt         : _,
            withdrawn_amount : _,
        } = arg1;
        0x2::transfer::public_transfer<T1>(0x2::dynamic_object_field::remove<vector<u8>, T1>(&mut arg0.id, 0x2::address::to_bytes(v1)), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
        arg0.staked_hominids = arg0.staked_hominids - 1;
    }

    public entry fun update_dprs<T0, T1: store + key>(arg0: &mut HominidsVault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 0);
        arg0.common_dpr = arg1;
        arg0.rare_dpr = arg2;
        arg0.epic_dpr = arg3;
        arg0.legendary_dpr = arg4;
    }

    public entry fun withdraw_rewards<T0, T1: store + key>(arg0: &mut HominidsVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.rewards, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

