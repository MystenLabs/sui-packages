module 0x2253c389b0ec932815d69905e2cc3d2c5091f27dc4c62c388222c4a0e04a6278::chang {
    struct CHANG has drop {
        dummy_field: bool,
    }

    struct FreezeCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct PauseCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct FreezeRegistry<phantom T0> has store, key {
        id: 0x2::object::UID,
        frozen_addresses: 0x2::table::Table<address, bool>,
    }

    struct PauseState<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct BurnedTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    struct AddressFrozen has copy, drop {
        address: address,
    }

    struct AddressUnfrozen has copy, drop {
        address: address,
    }

    struct TokenPaused has copy, drop {
        paused: bool,
    }

    struct MetadataUpdated has copy, drop {
        field: vector<u8>,
    }

    struct AuthorityRevoked has copy, drop {
        treasury_id: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHANG>, arg1: 0x2::coin::Coin<CHANG>) {
        0x2::coin::burn<CHANG>(arg0, arg1);
    }

    public entry fun freeze_address(arg0: &FreezeCap<CHANG>, arg1: &mut FreezeRegistry<CHANG>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen{address: arg2};
        0x2::event::emit<AddressFrozen>(v0);
    }

    fun init(arg0: CHANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHANG>(arg0, 9, b"CHANG", b"CHANG", x"e2809c4348414e47206973206120636f6d6d756e6974792d64726976656e206469676974616c206173736574206372656174656420666f7220646563656e7472616c697a65642074726164696e672c206c69717569646974792c20616e64206675747572652065636f73797374656d20646576656c6f706d656e742ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmSHfr9NZqGfjA9tQNgi7iqzfUfNrEr17fTfNGa794qm6c")), arg1);
        let v2 = v0;
        let v3 = FreezeCap<CHANG>{id: 0x2::object::new(arg1)};
        let v4 = PauseCap<CHANG>{id: 0x2::object::new(arg1)};
        let v5 = FreezeRegistry<CHANG>{
            id               : 0x2::object::new(arg1),
            frozen_addresses : 0x2::table::new<address, bool>(arg1),
        };
        let v6 = PauseState<CHANG>{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHANG>>(0x2::coin::mint<CHANG>(&mut v2, 2100000000000000000, arg1), v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANG>>(v2, v7);
        0x2::transfer::public_transfer<FreezeCap<CHANG>>(v3, v7);
        0x2::transfer::public_transfer<PauseCap<CHANG>>(v4, v7);
        0x2::transfer::public_share_object<FreezeRegistry<CHANG>>(v5);
        0x2::transfer::public_share_object<PauseState<CHANG>>(v6);
    }

    public fun is_frozen(arg0: &FreezeRegistry<CHANG>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public entry fun pause_token(arg0: &PauseCap<CHANG>, arg1: &mut PauseState<CHANG>) {
        arg1.is_paused = true;
        let v0 = TokenPaused{paused: true};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun renounce_treasury(arg0: 0x2::coin::TreasuryCap<CHANG>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::TreasuryCap<CHANG>>(&arg0);
        let v1 = BurnedTreasury<CHANG>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        };
        0x2::transfer::public_share_object<BurnedTreasury<CHANG>>(v1);
        let v2 = AuthorityRevoked{treasury_id: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<AuthorityRevoked>(v2);
    }

    public entry fun resume_token(arg0: &PauseCap<CHANG>, arg1: &mut PauseState<CHANG>) {
        arg1.is_paused = false;
        let v0 = TokenPaused{paused: false};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun transfer_checked(arg0: 0x2::coin::Coin<CHANG>, arg1: address, arg2: &FreezeRegistry<CHANG>, arg3: &PauseState<CHANG>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 2);
        assert!(!is_frozen(arg2, 0x2::tx_context::sender(arg4)), 1);
        assert!(!is_frozen(arg2, arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHANG>>(arg0, arg1);
    }

    public entry fun transfer_freeze_cap(arg0: FreezeCap<CHANG>, arg1: address) {
        0x2::transfer::public_transfer<FreezeCap<CHANG>>(arg0, arg1);
    }

    public entry fun transfer_pause_cap(arg0: PauseCap<CHANG>, arg1: address) {
        0x2::transfer::public_transfer<PauseCap<CHANG>>(arg0, arg1);
    }

    public entry fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<CHANG>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANG>>(arg0, arg1);
    }

    public entry fun unfreeze_address(arg0: &FreezeCap<CHANG>, arg1: &mut FreezeRegistry<CHANG>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen{address: arg2};
        0x2::event::emit<AddressUnfrozen>(v0);
    }

    // decompiled from Move bytecode v6
}

