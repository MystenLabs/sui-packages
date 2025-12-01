module 0x8a33502444388a14ae5f5efbfac85544c1c1ea7daadcfdd30048ec42b23be23f::slbt {
    struct SLBT has drop {
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

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLBT>, arg1: 0x2::coin::Coin<SLBT>) {
        0x2::coin::burn<SLBT>(arg0, arg1);
    }

    public entry fun freeze_address(arg0: &FreezeCap<SLBT>, arg1: &mut FreezeRegistry<SLBT>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen{address: arg2};
        0x2::event::emit<AddressFrozen>(v0);
    }

    fun init(arg0: SLBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLBT>(arg0, 9, b"SLBT", b"SUILabTesting", b"No description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmYRp5TpKXdQYhi6YaerXAzm94HSmrVfck8iwo7HfW6jFk")), arg1);
        let v2 = v0;
        let v3 = FreezeCap<SLBT>{id: 0x2::object::new(arg1)};
        let v4 = PauseCap<SLBT>{id: 0x2::object::new(arg1)};
        let v5 = FreezeRegistry<SLBT>{
            id               : 0x2::object::new(arg1),
            frozen_addresses : 0x2::table::new<address, bool>(arg1),
        };
        let v6 = PauseState<SLBT>{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLBT>>(0x2::coin::mint<SLBT>(&mut v2, 1000000000000000000, arg1), v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLBT>>(v2, v7);
        0x2::transfer::public_transfer<FreezeCap<SLBT>>(v3, v7);
        0x2::transfer::public_transfer<PauseCap<SLBT>>(v4, v7);
        0x2::transfer::public_share_object<FreezeRegistry<SLBT>>(v5);
        0x2::transfer::public_share_object<PauseState<SLBT>>(v6);
    }

    public fun is_frozen(arg0: &FreezeRegistry<SLBT>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public entry fun pause_token(arg0: &PauseCap<SLBT>, arg1: &mut PauseState<SLBT>) {
        arg1.is_paused = true;
        let v0 = TokenPaused{paused: true};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun renounce_treasury(arg0: 0x2::coin::TreasuryCap<SLBT>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::TreasuryCap<SLBT>>(&arg0);
        let v1 = BurnedTreasury<SLBT>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        };
        0x2::transfer::public_share_object<BurnedTreasury<SLBT>>(v1);
        let v2 = AuthorityRevoked{treasury_id: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<AuthorityRevoked>(v2);
    }

    public entry fun resume_token(arg0: &PauseCap<SLBT>, arg1: &mut PauseState<SLBT>) {
        arg1.is_paused = false;
        let v0 = TokenPaused{paused: false};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun transfer_checked(arg0: 0x2::coin::Coin<SLBT>, arg1: address, arg2: &FreezeRegistry<SLBT>, arg3: &PauseState<SLBT>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 2);
        assert!(!is_frozen(arg2, 0x2::tx_context::sender(arg4)), 1);
        assert!(!is_frozen(arg2, arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLBT>>(arg0, arg1);
    }

    public entry fun transfer_freeze_cap(arg0: FreezeCap<SLBT>, arg1: address) {
        0x2::transfer::public_transfer<FreezeCap<SLBT>>(arg0, arg1);
    }

    public entry fun transfer_pause_cap(arg0: PauseCap<SLBT>, arg1: address) {
        0x2::transfer::public_transfer<PauseCap<SLBT>>(arg0, arg1);
    }

    public entry fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<SLBT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLBT>>(arg0, arg1);
    }

    public entry fun unfreeze_address(arg0: &FreezeCap<SLBT>, arg1: &mut FreezeRegistry<SLBT>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen{address: arg2};
        0x2::event::emit<AddressUnfrozen>(v0);
    }

    // decompiled from Move bytecode v6
}

