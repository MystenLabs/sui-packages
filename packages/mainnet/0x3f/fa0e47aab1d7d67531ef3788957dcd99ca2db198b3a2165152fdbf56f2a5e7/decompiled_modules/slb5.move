module 0x3ffa0e47aab1d7d67531ef3788957dcd99ca2db198b3a2165152fdbf56f2a5e7::slb5 {
    struct SLB5 has drop {
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

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLB5>, arg1: 0x2::coin::Coin<SLB5>) {
        0x2::coin::burn<SLB5>(arg0, arg1);
    }

    public entry fun freeze_address(arg0: &FreezeCap<SLB5>, arg1: &mut FreezeRegistry<SLB5>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen{address: arg2};
        0x2::event::emit<AddressFrozen>(v0);
    }

    fun init(arg0: SLB5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLB5>(arg0, 9, b"SLB5", b"SUILab5", b"No description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.suilab.fun/suilabtoken.png")), arg1);
        let v2 = v0;
        let v3 = FreezeCap<SLB5>{id: 0x2::object::new(arg1)};
        let v4 = PauseCap<SLB5>{id: 0x2::object::new(arg1)};
        let v5 = FreezeRegistry<SLB5>{
            id               : 0x2::object::new(arg1),
            frozen_addresses : 0x2::table::new<address, bool>(arg1),
        };
        let v6 = PauseState<SLB5>{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLB5>>(0x2::coin::mint<SLB5>(&mut v2, 1000000000000000000, arg1), v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLB5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLB5>>(v2, v7);
        0x2::transfer::public_transfer<FreezeCap<SLB5>>(v3, v7);
        0x2::transfer::public_transfer<PauseCap<SLB5>>(v4, v7);
        0x2::transfer::public_share_object<FreezeRegistry<SLB5>>(v5);
        0x2::transfer::public_share_object<PauseState<SLB5>>(v6);
    }

    public fun is_frozen(arg0: &FreezeRegistry<SLB5>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public entry fun pause_token(arg0: &PauseCap<SLB5>, arg1: &mut PauseState<SLB5>) {
        arg1.is_paused = true;
        let v0 = TokenPaused{paused: true};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun renounce_treasury(arg0: 0x2::coin::TreasuryCap<SLB5>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::TreasuryCap<SLB5>>(&arg0);
        let v1 = BurnedTreasury<SLB5>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        };
        0x2::transfer::public_share_object<BurnedTreasury<SLB5>>(v1);
        let v2 = AuthorityRevoked{treasury_id: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<AuthorityRevoked>(v2);
    }

    public entry fun resume_token(arg0: &PauseCap<SLB5>, arg1: &mut PauseState<SLB5>) {
        arg1.is_paused = false;
        let v0 = TokenPaused{paused: false};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun transfer_checked(arg0: 0x2::coin::Coin<SLB5>, arg1: address, arg2: &FreezeRegistry<SLB5>, arg3: &PauseState<SLB5>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 2);
        assert!(!is_frozen(arg2, 0x2::tx_context::sender(arg4)), 1);
        assert!(!is_frozen(arg2, arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLB5>>(arg0, arg1);
    }

    public entry fun transfer_freeze_cap(arg0: FreezeCap<SLB5>, arg1: address) {
        0x2::transfer::public_transfer<FreezeCap<SLB5>>(arg0, arg1);
    }

    public entry fun transfer_pause_cap(arg0: PauseCap<SLB5>, arg1: address) {
        0x2::transfer::public_transfer<PauseCap<SLB5>>(arg0, arg1);
    }

    public entry fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<SLB5>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLB5>>(arg0, arg1);
    }

    public entry fun unfreeze_address(arg0: &FreezeCap<SLB5>, arg1: &mut FreezeRegistry<SLB5>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen{address: arg2};
        0x2::event::emit<AddressUnfrozen>(v0);
    }

    // decompiled from Move bytecode v6
}

