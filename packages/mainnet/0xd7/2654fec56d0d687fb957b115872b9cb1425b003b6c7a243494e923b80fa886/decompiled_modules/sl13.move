module 0xd72654fec56d0d687fb957b115872b9cb1425b003b6c7a243494e923b80fa886::sl13 {
    struct SL13 has drop {
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

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SL13>, arg1: 0x2::coin::Coin<SL13>) {
        0x2::coin::burn<SL13>(arg0, arg1);
    }

    public entry fun freeze_address(arg0: &FreezeCap<SL13>, arg1: &mut FreezeRegistry<SL13>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen{address: arg2};
        0x2::event::emit<AddressFrozen>(v0);
    }

    fun init(arg0: SL13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SL13>(arg0, 9, b"SL13", b"SUILab13", b"No description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmbnKJhkaRrMR296MAFCQRDyy4X9G19a2bm3XGtDJiYTNE")), arg1);
        let v2 = v0;
        let v3 = FreezeCap<SL13>{id: 0x2::object::new(arg1)};
        let v4 = PauseCap<SL13>{id: 0x2::object::new(arg1)};
        let v5 = FreezeRegistry<SL13>{
            id               : 0x2::object::new(arg1),
            frozen_addresses : 0x2::table::new<address, bool>(arg1),
        };
        let v6 = PauseState<SL13>{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SL13>>(0x2::coin::mint<SL13>(&mut v2, 1000000000000000000, arg1), v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SL13>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SL13>>(v2, v7);
        0x2::transfer::public_transfer<FreezeCap<SL13>>(v3, v7);
        0x2::transfer::public_transfer<PauseCap<SL13>>(v4, v7);
        0x2::transfer::public_share_object<FreezeRegistry<SL13>>(v5);
        0x2::transfer::public_share_object<PauseState<SL13>>(v6);
    }

    public fun is_frozen(arg0: &FreezeRegistry<SL13>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public entry fun pause_token(arg0: &PauseCap<SL13>, arg1: &mut PauseState<SL13>) {
        arg1.is_paused = true;
        let v0 = TokenPaused{paused: true};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun renounce_treasury(arg0: 0x2::coin::TreasuryCap<SL13>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::TreasuryCap<SL13>>(&arg0);
        let v1 = BurnedTreasury<SL13>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        };
        0x2::transfer::public_share_object<BurnedTreasury<SL13>>(v1);
        let v2 = AuthorityRevoked{treasury_id: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<AuthorityRevoked>(v2);
    }

    public entry fun resume_token(arg0: &PauseCap<SL13>, arg1: &mut PauseState<SL13>) {
        arg1.is_paused = false;
        let v0 = TokenPaused{paused: false};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun transfer_checked(arg0: 0x2::coin::Coin<SL13>, arg1: address, arg2: &FreezeRegistry<SL13>, arg3: &PauseState<SL13>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 2);
        assert!(!is_frozen(arg2, 0x2::tx_context::sender(arg4)), 1);
        assert!(!is_frozen(arg2, arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SL13>>(arg0, arg1);
    }

    public entry fun transfer_freeze_cap(arg0: FreezeCap<SL13>, arg1: address) {
        0x2::transfer::public_transfer<FreezeCap<SL13>>(arg0, arg1);
    }

    public entry fun transfer_pause_cap(arg0: PauseCap<SL13>, arg1: address) {
        0x2::transfer::public_transfer<PauseCap<SL13>>(arg0, arg1);
    }

    public entry fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<SL13>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SL13>>(arg0, arg1);
    }

    public entry fun unfreeze_address(arg0: &FreezeCap<SL13>, arg1: &mut FreezeRegistry<SL13>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen{address: arg2};
        0x2::event::emit<AddressUnfrozen>(v0);
    }

    // decompiled from Move bytecode v6
}

