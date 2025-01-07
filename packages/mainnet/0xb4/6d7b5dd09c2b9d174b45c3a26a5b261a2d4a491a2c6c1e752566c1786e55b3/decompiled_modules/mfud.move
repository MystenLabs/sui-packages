module 0xd8f04cd2a16c19c17428c3b4c22b01dd06740423b93fb7ee88fbe2676a82849d::mfud {
    struct MFUD has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        authority: 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::Authority,
        treasury_cap: 0x2::coin::TreasuryCap<MFUD>,
        balance: 0x2::balance::Balance<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD>,
        version: u64,
    }

    public fun burn(arg0: &mut Registry, arg1: 0x2::coin::Coin<MFUD>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD> {
        version_check(arg0);
        0x2::coin::from_balance<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD>(0x2::balance::split<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD>(&mut arg0.balance, 0x2::coin::burn<MFUD>(&mut arg0.treasury_cap, arg1) * 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(6 + 5 - 6)), arg2)
    }

    public fun mint(arg0: &mut Registry, arg1: vector<0x2::coin::Coin<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MFUD> {
        version_check(arg0);
        0x2::balance::join<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD>(&mut arg0.balance, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::extract_balance<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD>(arg1, arg2 * 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(6 + 5 - 6), arg3));
        0x2::coin::mint<MFUD>(&mut arg0.treasury_cap, arg2, arg3)
    }

    entry fun add_authorized_user(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::verify(&arg0.authority, arg2);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::add_authorized_user(&mut arg0.authority, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    entry fun remove_authorized_user(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::verify(&arg0.authority, arg2);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::remove_authorized_user(&mut arg0.authority, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    entry fun burn_entry(arg0: &mut Registry, arg1: 0x2::coin::Coin<MFUD>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = burn(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: MFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFUD>(arg0, (6 as u8), b"MFUD", b"Typus MFUD", b"MFUD on Sui maintained by Typus Lab", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Registry{
            id           : 0x2::object::new(arg1),
            authority    : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::new(0x1::vector::singleton<address>(0x2::tx_context::sender(arg1)), arg1),
            treasury_cap : v0,
            balance      : 0x2::balance::zero<0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::FUD>(),
            version      : 0,
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MFUD>>(v1);
        0x2::transfer::share_object<Registry>(v2);
    }

    entry fun upgrade_registry(arg0: &mut Registry) {
        version_check(arg0);
        arg0.version = 0;
    }

    fun version_check(arg0: &Registry) {
        assert!(0 >= arg0.version, 0);
    }

    // decompiled from Move bytecode v6
}

