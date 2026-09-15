module 0x70805e134dca030f32af7e006fddc3e32027d5dbe22611f3f8d8a9d7cf021da0::rcd {
    struct RCD has drop {
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

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RCD>, arg1: 0x2::coin::Coin<RCD>) {
        0x2::coin::burn<RCD>(arg0, arg1);
    }

    public entry fun freeze_address(arg0: &FreezeCap<RCD>, arg1: &mut FreezeRegistry<RCD>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen{address: arg2};
        0x2::event::emit<AddressFrozen>(v0);
    }

    fun init(arg0: RCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCD>(arg0, 9, b"RCD", b"RCD Coin", x"52434420436f696e202852434429206973206120636f6d6d756e6974792d64726976656e20424e4220536d61727420436861696e2070726f6a65637420666f6375736564206f6e20e2809c426c6f636b636861696e20666f722048756d616e6974792ce2809d20737570706f7274696e6720656475636174696f6e2c206865616c7468636172652c20666f6f6420617373697374616e63652c20616e6420646973616476616e746167656420636f6d6d756e69746965732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmU4f5JNcctaDXTkuPDddMgbGFxeKN2rx3ExFZnN8piXjx")), arg1);
        let v2 = v0;
        let v3 = FreezeCap<RCD>{id: 0x2::object::new(arg1)};
        let v4 = PauseCap<RCD>{id: 0x2::object::new(arg1)};
        let v5 = FreezeRegistry<RCD>{
            id               : 0x2::object::new(arg1),
            frozen_addresses : 0x2::table::new<address, bool>(arg1),
        };
        let v6 = PauseState<RCD>{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RCD>>(0x2::coin::mint<RCD>(&mut v2, 50000000000000000, arg1), v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCD>>(v2, v7);
        0x2::transfer::public_transfer<FreezeCap<RCD>>(v3, v7);
        0x2::transfer::public_transfer<PauseCap<RCD>>(v4, v7);
        0x2::transfer::public_share_object<FreezeRegistry<RCD>>(v5);
        0x2::transfer::public_share_object<PauseState<RCD>>(v6);
    }

    public fun is_frozen(arg0: &FreezeRegistry<RCD>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public entry fun pause_token(arg0: &PauseCap<RCD>, arg1: &mut PauseState<RCD>) {
        arg1.is_paused = true;
        let v0 = TokenPaused{paused: true};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun renounce_treasury(arg0: 0x2::coin::TreasuryCap<RCD>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::TreasuryCap<RCD>>(&arg0);
        let v1 = BurnedTreasury<RCD>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        };
        0x2::transfer::public_share_object<BurnedTreasury<RCD>>(v1);
        let v2 = AuthorityRevoked{treasury_id: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<AuthorityRevoked>(v2);
    }

    public entry fun resume_token(arg0: &PauseCap<RCD>, arg1: &mut PauseState<RCD>) {
        arg1.is_paused = false;
        let v0 = TokenPaused{paused: false};
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun transfer_checked(arg0: 0x2::coin::Coin<RCD>, arg1: address, arg2: &FreezeRegistry<RCD>, arg3: &PauseState<RCD>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 2);
        assert!(!is_frozen(arg2, 0x2::tx_context::sender(arg4)), 1);
        assert!(!is_frozen(arg2, arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RCD>>(arg0, arg1);
    }

    public entry fun transfer_freeze_cap(arg0: FreezeCap<RCD>, arg1: address) {
        0x2::transfer::public_transfer<FreezeCap<RCD>>(arg0, arg1);
    }

    public entry fun transfer_pause_cap(arg0: PauseCap<RCD>, arg1: address) {
        0x2::transfer::public_transfer<PauseCap<RCD>>(arg0, arg1);
    }

    public entry fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<RCD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCD>>(arg0, arg1);
    }

    public entry fun unfreeze_address(arg0: &FreezeCap<RCD>, arg1: &mut FreezeRegistry<RCD>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen{address: arg2};
        0x2::event::emit<AddressUnfrozen>(v0);
    }

    // decompiled from Move bytecode v6
}

