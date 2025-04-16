module 0x115428bc9526e03ad4a16d1988c0a12bd9456dfc7ff7952af1aa9703e7465df2::agijoe_token {
    struct TokenConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AGIJOE has drop {
        dummy_field: bool,
    }

    struct AGIJOE_TOKEN has drop {
        dummy_field: bool,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
    }

    struct OwnershipTransferredEvent has copy, drop {
        new_owner: address,
    }

    public fun balance(arg0: &0x2::coin::Coin<AGIJOE>) : u64 {
        0x2::coin::value<AGIJOE>(arg0)
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AGIJOE>, arg1: 0x2::coin::Coin<AGIJOE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<AGIJOE>(arg0, arg1);
    }

    public entry fun split(arg0: &TokenConfig, arg1: &mut 0x2::coin::Coin<AGIJOE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGIJOE>>(0x2::coin::split<AGIJOE>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<AGIJOE>) : u64 {
        0x2::coin::total_supply<AGIJOE>(arg0)
    }

    public entry fun transfer(arg0: &TokenConfig, arg1: 0x2::coin::Coin<AGIJOE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGIJOE>>(arg1, arg2);
    }

    fun init(arg0: AGIJOE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGIJOE_TOKEN>(arg0, 2, b"AGIJOE", b"AGIJOE Xolo Token", b"AGIJOE for AZTEQ Metaverse Xolo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/azteqmetaverse/AZTEQ/main/xolo_agijoe_v1_token.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGIJOE_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGIJOE_TOKEN>>(0x2::coin::from_balance<AGIJOE_TOKEN>(0x2::coin::mint_balance<AGIJOE_TOKEN>(&mut v3, 10000000000), arg1), v0);
        let v4 = TokenConfig{
            id     : 0x2::object::new(arg1),
            paused : false,
        };
        0x2::transfer::share_object<TokenConfig>(v4);
        let v5 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<OwnerCap>(v5, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGIJOE_TOKEN>>(v3, v0);
    }

    public fun is_paused(arg0: &TokenConfig) : bool {
        arg0.paused
    }

    public entry fun merge(arg0: &TokenConfig, arg1: &mut 0x2::coin::Coin<AGIJOE>, arg2: 0x2::coin::Coin<AGIJOE>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x2::coin::join<AGIJOE>(arg1, arg2);
    }

    public entry fun pause(arg0: &OwnerCap, arg1: &mut TokenConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 2);
        arg1.paused = true;
        let v0 = PauseEvent{paused: true};
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun transfer_ownership(arg0: OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<OwnerCap>(arg0, arg1);
        let v0 = OwnershipTransferredEvent{new_owner: arg1};
        0x2::event::emit<OwnershipTransferredEvent>(v0);
    }

    public entry fun unpause(arg0: &OwnerCap, arg1: &mut TokenConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.paused, 1);
        arg1.paused = false;
        let v0 = PauseEvent{paused: false};
        0x2::event::emit<PauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

