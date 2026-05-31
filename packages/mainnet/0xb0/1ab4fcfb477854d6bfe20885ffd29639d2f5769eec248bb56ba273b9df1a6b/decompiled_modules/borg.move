module 0xb01ab4fcfb477854d6bfe20885ffd29639d2f5769eec248bb56ba273b9df1a6b::borg {
    struct BORG has drop {
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

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BORG>, arg1: 0x2::coin::Coin<BORG>) {
        0x2::coin::burn<BORG>(arg0, arg1);
    }

    public entry fun freeze_address(arg0: &FreezeCap<BORG>, arg1: &mut FreezeRegistry<BORG>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen{address: arg2};
        0x2::event::emit<AddressFrozen>(v0);
    }

    fun init(arg0: BORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORG>(arg0, 9, b"BORG", b"suiborg", x"4f6666696369616c20535549424f52472050726f746f636f6c20e28094205574696c6974792c205374616b696e672c20616e6420496d706163742e20466978656420737570706c79206f6620313030303030303030303020424f52472e204275696c7420666f72206c6f6e672d7465726d2076616c75652c20636f6d6d756e69747920726577617264732c20616e6420676c6f62616c2072657363756520696e6974696174697665732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmYZSdFTXwG3v6HenDYcSMDJMFUpWTPq8eV68MpCi4cQzA")), arg1);
        let v2 = v0;
        let v3 = FreezeCap<BORG>{id: 0x2::object::new(arg1)};
        let v4 = PauseCap<BORG>{id: 0x2::object::new(arg1)};
        let v5 = FreezeRegistry<BORG>{
            id               : 0x2::object::new(arg1),
            frozen_addresses : 0x2::table::new<address, bool>(arg1),
        };
        let v6 = PauseState<BORG>{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BORG>>(0x2::coin::mint<BORG>(&mut v2, 10000000000000000000, arg1), v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BORG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORG>>(v2, v7);
        0x2::transfer::public_transfer<FreezeCap<BORG>>(v3, v7);
        0x2::transfer::public_transfer<PauseCap<BORG>>(v4, v7);
        0x2::transfer::public_share_object<FreezeRegistry<BORG>>(v5);
        0x2::transfer::public_share_object<PauseState<BORG>>(v6);
    }

    public fun is_frozen(arg0: &FreezeRegistry<BORG>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public entry fun pause_token(arg0: &PauseCap<BORG>, arg1: &mut PauseState<BORG>) {
        arg1.is_paused = true;
        let v0 = TokenPaused{paused: true};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun renounce_treasury(arg0: 0x2::coin::TreasuryCap<BORG>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::TreasuryCap<BORG>>(&arg0);
        let v1 = BurnedTreasury<BORG>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        };
        0x2::transfer::public_share_object<BurnedTreasury<BORG>>(v1);
        let v2 = AuthorityRevoked{treasury_id: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<AuthorityRevoked>(v2);
    }

    public entry fun resume_token(arg0: &PauseCap<BORG>, arg1: &mut PauseState<BORG>) {
        arg1.is_paused = false;
        let v0 = TokenPaused{paused: false};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun transfer_checked(arg0: 0x2::coin::Coin<BORG>, arg1: address, arg2: &FreezeRegistry<BORG>, arg3: &PauseState<BORG>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 2);
        assert!(!is_frozen(arg2, 0x2::tx_context::sender(arg4)), 1);
        assert!(!is_frozen(arg2, arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BORG>>(arg0, arg1);
    }

    public entry fun transfer_freeze_cap(arg0: FreezeCap<BORG>, arg1: address) {
        0x2::transfer::public_transfer<FreezeCap<BORG>>(arg0, arg1);
    }

    public entry fun transfer_pause_cap(arg0: PauseCap<BORG>, arg1: address) {
        0x2::transfer::public_transfer<PauseCap<BORG>>(arg0, arg1);
    }

    public entry fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<BORG>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORG>>(arg0, arg1);
    }

    public entry fun unfreeze_address(arg0: &FreezeCap<BORG>, arg1: &mut FreezeRegistry<BORG>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen{address: arg2};
        0x2::event::emit<AddressUnfrozen>(v0);
    }

    // decompiled from Move bytecode v6
}

