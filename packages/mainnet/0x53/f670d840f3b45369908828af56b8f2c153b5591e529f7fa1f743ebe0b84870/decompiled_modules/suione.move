module 0x53f670d840f3b45369908828af56b8f2c153b5591e529f7fa1f743ebe0b84870::suione {
    struct SUIONE has drop {
        dummy_field: bool,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUIONE>,
        fee_recipient: address,
        fee_mist: u64,
        public_minted: u64,
        lp_recipient: address,
        frozen: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DelegationKey has copy, drop, store {
        owner: address,
        relayer: address,
    }

    public entry fun mint(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!arg0.frozen, 1);
        assert!(arg2 == v0, 4);
        assert!(arg3 == 500000000000, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee_mist, 0);
        assert!(arg0.public_minted + arg3 <= 500000000000000, 2);
        if (0x2::dynamic_field::exists<address>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, v0);
            assert!(*v1 < 2, 3);
            *v1 = *v1 + 1;
        } else {
            0x2::dynamic_field::add<address, u64>(&mut arg0.id, v0, 1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.fee_recipient);
        arg0.public_minted = arg0.public_minted + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIONE>>(0x2::coin::mint<SUIONE>(&mut arg0.treasury_cap, arg3, arg4), arg2);
    }

    public entry fun approve_relayer(arg0: &mut MintConfig, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2 > 0 && arg2 <= 2, 0);
        let v1 = mint_count(arg0, v0);
        let v2 = if (v1 >= 2) {
            0
        } else {
            2 - v1
        };
        let v3 = if (arg2 > v2) {
            v2
        } else {
            arg2
        };
        assert!(v3 > 0, 3);
        let v4 = DelegationKey{
            owner   : v0,
            relayer : arg1,
        };
        if (0x2::dynamic_field::exists<DelegationKey>(&arg0.id, v4)) {
            *0x2::dynamic_field::borrow_mut<DelegationKey, u64>(&mut arg0.id, v4) = v3;
        } else {
            0x2::dynamic_field::add<DelegationKey, u64>(&mut arg0.id, v4, v3);
        };
    }

    public entry fun approve_relayer_prepaid(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg3 > 0 && arg3 <= 2, 0);
        let v1 = mint_count(arg0, v0);
        let v2 = if (v1 >= 2) {
            0
        } else {
            2 - v1
        };
        let v3 = if (arg3 > v2) {
            v2
        } else {
            arg3
        };
        assert!(v3 > 0, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee_mist * v3, 0);
        let v4 = DelegationKey{
            owner   : v0,
            relayer : arg2,
        };
        if (0x2::dynamic_field::exists<DelegationKey>(&arg0.id, v4)) {
            *0x2::dynamic_field::borrow_mut<DelegationKey, u64>(&mut arg0.id, v4) = v3;
        } else {
            0x2::dynamic_field::add<DelegationKey, u64>(&mut arg0.id, v4, v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.fee_recipient);
    }

    public entry fun create_config(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<SUIONE>, arg2: address, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIONE>>(0x2::coin::mint<SUIONE>(&mut arg1, 500000000000000, arg5), arg3);
        let v0 = MintConfig{
            id            : 0x2::object::new(arg5),
            treasury_cap  : arg1,
            fee_recipient : arg2,
            fee_mist      : arg4,
            public_minted : 0,
            lp_recipient  : arg3,
            frozen        : false,
        };
        0x2::transfer::share_object<MintConfig>(v0);
    }

    public entry fun delegated_mint(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.frozen, 1);
        assert!(arg3 == 500000000000, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee_mist, 0);
        assert!(arg0.public_minted + arg3 <= 500000000000000, 2);
        let v0 = DelegationKey{
            owner   : arg2,
            relayer : 0x2::tx_context::sender(arg4),
        };
        assert!(0x2::dynamic_field::exists<DelegationKey>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<DelegationKey, u64>(&mut arg0.id, v0);
        assert!(*v1 > 0, 6);
        *v1 = *v1 - 1;
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg2)) {
            let v2 = 0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, arg2);
            assert!(*v2 < 2, 3);
            *v2 = *v2 + 1;
        } else {
            0x2::dynamic_field::add<address, u64>(&mut arg0.id, arg2, 1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.fee_recipient);
        arg0.public_minted = arg0.public_minted + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIONE>>(0x2::coin::mint<SUIONE>(&mut arg0.treasury_cap, arg3, arg4), arg2);
    }

    public fun delegated_mint_count(arg0: &MintConfig, arg1: address, arg2: address) : u64 {
        let v0 = DelegationKey{
            owner   : arg1,
            relayer : arg2,
        };
        if (0x2::dynamic_field::exists<DelegationKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<DelegationKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public entry fun delegated_mint_prepaid(arg0: &mut MintConfig, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.frozen, 1);
        assert!(arg2 == 500000000000, 0);
        assert!(arg0.public_minted + arg2 <= 500000000000000, 2);
        let v0 = DelegationKey{
            owner   : arg1,
            relayer : 0x2::tx_context::sender(arg3),
        };
        assert!(0x2::dynamic_field::exists<DelegationKey>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<DelegationKey, u64>(&mut arg0.id, v0);
        assert!(*v1 > 0, 6);
        *v1 = *v1 - 1;
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, arg1);
            assert!(*v2 < 2, 3);
            *v2 = *v2 + 1;
        } else {
            0x2::dynamic_field::add<address, u64>(&mut arg0.id, arg1, 1);
        };
        arg0.public_minted = arg0.public_minted + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIONE>>(0x2::coin::mint<SUIONE>(&mut arg0.treasury_cap, arg2, arg3), arg1);
    }

    fun init(arg0: SUIONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONE>(arg0, 6, b"SU1", b"SUI ONE", b"SUI ONE public mint token on Sui mainnet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suione.onrender.com/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONE>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun lp_allocation() : u64 {
        500000000000000
    }

    public fun max_mints_per_wallet() : u64 {
        2
    }

    public fun mint_count(arg0: &MintConfig, arg1: address) : u64 {
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<address, u64>(&arg0.id, arg1)
        } else {
            0
        }
    }

    public fun public_mint_allocation() : u64 {
        500000000000000
    }

    public entry fun revoke_relayer(arg0: &mut MintConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DelegationKey{
            owner   : 0x2::tx_context::sender(arg2),
            relayer : arg1,
        };
        if (0x2::dynamic_field::exists<DelegationKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<DelegationKey, u64>(&mut arg0.id, v0);
        };
    }

    public entry fun set_fee(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address, arg3: u64) {
        arg1.fee_recipient = arg2;
        arg1.fee_mist = arg3;
    }

    public entry fun set_frozen(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.frozen = arg2;
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    // decompiled from Move bytecode v7
}

