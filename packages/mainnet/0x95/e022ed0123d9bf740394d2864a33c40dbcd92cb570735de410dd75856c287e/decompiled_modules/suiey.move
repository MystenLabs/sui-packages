module 0x95e022ed0123d9bf740394d2864a33c40dbcd92cb570735de410dd75856c287e::suiey {
    struct SUIEY has drop {
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

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIEY>, arg1: 0x2::coin::Coin<SUIEY>) {
        0x2::coin::burn<SUIEY>(arg0, arg1);
    }

    public entry fun freeze_address(arg0: &FreezeCap<SUIEY>, arg1: &mut FreezeRegistry<SUIEY>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen{address: arg2};
        0x2::event::emit<AddressFrozen>(v0);
    }

    fun init(arg0: SUIEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEY>(arg0, 9, b"SUIEY", b"SUIEY the PIGLET", x"e2809c4f696e6b20746f206561726e2c2073717565616c20666f72206761696e732120426f726e206f6e2053554920616e6420706f776572656420627920636f6d6d756e6974792c2053554945592069732074686520706c617966756c207069676c65742070726f76696e67206d656d65732c206d61726b6574732c20616e6420676f6f642076696265732063616e20616c6c206d6f6f6e20746f6765746865722ee2809d20f09f9a80f09f8c95", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plum-objective-pelican-269.mypinata.cloud/ipfs/bafybeifpm74wbxcdt6zhdjbhdjpg4hrcq47hqayxejyibt5gc4olb6chgq")), arg1);
        let v2 = v0;
        let v3 = FreezeCap<SUIEY>{id: 0x2::object::new(arg1)};
        let v4 = PauseCap<SUIEY>{id: 0x2::object::new(arg1)};
        let v5 = FreezeRegistry<SUIEY>{
            id               : 0x2::object::new(arg1),
            frozen_addresses : 0x2::table::new<address, bool>(arg1),
        };
        let v6 = PauseState<SUIEY>{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIEY>>(0x2::coin::mint<SUIEY>(&mut v2, 1000000000000000000, arg1), v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEY>>(v2, v7);
        0x2::transfer::public_transfer<FreezeCap<SUIEY>>(v3, v7);
        0x2::transfer::public_transfer<PauseCap<SUIEY>>(v4, v7);
        0x2::transfer::public_share_object<FreezeRegistry<SUIEY>>(v5);
        0x2::transfer::public_share_object<PauseState<SUIEY>>(v6);
    }

    public fun is_frozen(arg0: &FreezeRegistry<SUIEY>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public entry fun pause_token(arg0: &PauseCap<SUIEY>, arg1: &mut PauseState<SUIEY>) {
        arg1.is_paused = true;
        let v0 = TokenPaused{paused: true};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun renounce_treasury(arg0: 0x2::coin::TreasuryCap<SUIEY>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::TreasuryCap<SUIEY>>(&arg0);
        let v1 = BurnedTreasury<SUIEY>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        };
        0x2::transfer::public_share_object<BurnedTreasury<SUIEY>>(v1);
        let v2 = AuthorityRevoked{treasury_id: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<AuthorityRevoked>(v2);
    }

    public entry fun resume_token(arg0: &PauseCap<SUIEY>, arg1: &mut PauseState<SUIEY>) {
        arg1.is_paused = false;
        let v0 = TokenPaused{paused: false};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun transfer_checked(arg0: 0x2::coin::Coin<SUIEY>, arg1: address, arg2: &FreezeRegistry<SUIEY>, arg3: &PauseState<SUIEY>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 2);
        assert!(!is_frozen(arg2, 0x2::tx_context::sender(arg4)), 1);
        assert!(!is_frozen(arg2, arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIEY>>(arg0, arg1);
    }

    public entry fun transfer_freeze_cap(arg0: FreezeCap<SUIEY>, arg1: address) {
        0x2::transfer::public_transfer<FreezeCap<SUIEY>>(arg0, arg1);
    }

    public entry fun transfer_pause_cap(arg0: PauseCap<SUIEY>, arg1: address) {
        0x2::transfer::public_transfer<PauseCap<SUIEY>>(arg0, arg1);
    }

    public entry fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<SUIEY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEY>>(arg0, arg1);
    }

    public entry fun unfreeze_address(arg0: &FreezeCap<SUIEY>, arg1: &mut FreezeRegistry<SUIEY>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen{address: arg2};
        0x2::event::emit<AddressUnfrozen>(v0);
    }

    // decompiled from Move bytecode v6
}

