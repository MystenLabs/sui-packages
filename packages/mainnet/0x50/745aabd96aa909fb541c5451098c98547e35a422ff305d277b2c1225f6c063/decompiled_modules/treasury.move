module 0x50745aabd96aa909fb541c5451098c98547e35a422ff305d277b2c1225f6c063::treasury {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct TreasuryConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        mint_caps: 0x2::table::Table<0x2::object::ID, bool>,
        enable: bool,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        user_addresses: vector<address>,
        users: 0x2::table::Table<address, u64>,
    }

    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Resume has copy, drop {
        dummy_field: bool,
    }

    struct AddMintCap has copy, drop {
        user: address,
        cap_id: 0x2::object::ID,
    }

    struct RemoveMintCap has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct CreateTreasuryCoin has copy, drop {
        id: 0x2::object::ID,
    }

    struct WithdrawTreasuryCap has copy, drop {
        sender: address,
        treasury_id: 0x2::object::ID,
        treasury_cap_id: 0x2::object::ID,
    }

    struct MintBatch has copy, drop {
        treasury_id: 0x2::object::ID,
        recipients: vector<address>,
        amounts: vector<u64>,
        token: 0x1::ascii::String,
        mint_cap_id: 0x2::object::ID,
        mint_cap_user: address,
        mint_time: u64,
    }

    entry fun add_mint_cap(arg0: &AdminCap, arg1: &mut TreasuryConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 3);
        let v0 = MintCap{
            id    : 0x2::object::new(arg3),
            owner : arg2,
        };
        let v1 = 0x2::object::id<MintCap>(&v0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.mint_caps, v1, true);
        let v2 = AddMintCap{
            user   : arg2,
            cap_id : v1,
        };
        0x2::event::emit<AddMintCap>(v2);
        0x2::transfer::public_transfer<MintCap>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = TreasuryConfig{
            id        : 0x2::object::new(arg0),
            version   : 1,
            mint_caps : 0x2::table::new<0x2::object::ID, bool>(arg0),
            enable    : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<TreasuryConfig>(v1);
    }

    entry fun init_treasury_coin<T0>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id             : 0x2::object::new(arg2),
            treasury_cap   : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg1),
            user_addresses : 0x1::vector::empty<address>(),
            users          : 0x2::table::new<address, u64>(arg2),
        };
        let v1 = CreateTreasuryCoin{id: 0x2::object::id<Treasury<T0>>(&v0)};
        0x2::event::emit<CreateTreasuryCoin>(v1);
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut TreasuryConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    public fun mint<T0>(arg0: &AdminCap, arg1: &TreasuryConfig, arg2: &mut Treasury<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 3);
        0x2::coin::mint_and_transfer<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg2.treasury_cap), arg3, arg4, arg5);
    }

    public fun mint_batch<T0>(arg0: &TreasuryConfig, arg1: &MintCap, arg2: &mut Treasury<T0>, arg3: vector<address>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 3);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.mint_caps, 0x2::object::id<MintCap>(arg1)), 7);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 5);
        assert!(v0 <= 100, 6);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<address>(&arg3, v1);
            let v3 = 0x1::vector::borrow<u64>(&arg4, v1);
            assert!(*v3 > 0, 8);
            0x1::vector::push_back<address>(&mut arg2.user_addresses, *v2);
            if (0x2::table::contains<address, u64>(&arg2.users, *v2)) {
                let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg2.users, *v2);
                *v4 = *v4 + *v3;
            } else {
                0x2::table::add<address, u64>(&mut arg2.users, *v2, *v3);
            };
            0x2::coin::mint_and_transfer<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg2.treasury_cap), *v3, *v2, arg6);
            v1 = v1 + 1;
        };
        let v5 = MintBatch{
            treasury_id   : 0x2::object::id<Treasury<T0>>(arg2),
            recipients    : arg3,
            amounts       : arg4,
            token         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            mint_cap_id   : 0x2::object::id<MintCap>(arg1),
            mint_cap_user : arg1.owner,
            mint_time     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<MintBatch>(v5);
    }

    entry fun pause(arg0: &AdminCap, arg1: &mut TreasuryConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        arg1.enable = false;
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun remove_mint_cap(arg0: &AdminCap, arg1: &mut TreasuryConfig, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 3);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.mint_caps, arg2), 4);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.mint_caps, arg2);
        let v0 = RemoveMintCap{cap_id: arg2};
        0x2::event::emit<RemoveMintCap>(v0);
    }

    entry fun resume(arg0: &AdminCap, arg1: &mut TreasuryConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        arg1.enable = true;
        let v0 = Resume{dummy_field: false};
        0x2::event::emit<Resume>(v0);
    }

    entry fun withdraw_treasury_cap<T0>(arg0: &AdminCap, arg1: &TreasuryConfig, arg2: &mut Treasury<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        let v0 = 0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg2.treasury_cap);
        let v1 = WithdrawTreasuryCap{
            sender          : 0x2::tx_context::sender(arg3),
            treasury_id     : 0x2::object::id<Treasury<T0>>(arg2),
            treasury_cap_id : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&v0),
        };
        0x2::event::emit<WithdrawTreasuryCap>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

