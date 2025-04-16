module 0x79ada57563c07b5c8ebde749198a1774f6e390b90757a6327c0cfefc2f9fd127::azteq_token {
    struct TokenConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AZTEQ has drop {
        dummy_field: bool,
    }

    struct AZTEQ_TOKEN has drop {
        dummy_field: bool,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
    }

    struct OwnershipTransferredEvent has copy, drop {
        new_owner: address,
    }

    public fun balance(arg0: &0x2::coin::Coin<AZTEQ>) : u64 {
        0x2::coin::value<AZTEQ>(arg0)
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AZTEQ>, arg1: 0x2::coin::Coin<AZTEQ>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<AZTEQ>(arg0, arg1);
    }

    public entry fun split(arg0: &TokenConfig, arg1: &mut 0x2::coin::Coin<AZTEQ>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AZTEQ>>(0x2::coin::split<AZTEQ>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<AZTEQ>) : u64 {
        0x2::coin::total_supply<AZTEQ>(arg0)
    }

    public entry fun transfer(arg0: &TokenConfig, arg1: 0x2::coin::Coin<AZTEQ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AZTEQ>>(arg1, arg2);
    }

    fun init(arg0: AZTEQ_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AZTEQ_TOKEN>(arg0, 4, b"AZTEQ", b"AZTEQ Metaverse", b"AZTEQ Coin (Sui) for the AZTEQ Metaverse ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/azteqmetaverse/AZTEQ/main/AZTEQ_V3_Coin.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZTEQ_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<AZTEQ_TOKEN>>(0x2::coin::from_balance<AZTEQ_TOKEN>(0x2::coin::mint_balance<AZTEQ_TOKEN>(&mut v3, 1162031500000), arg1), v0);
        let v4 = TokenConfig{
            id     : 0x2::object::new(arg1),
            paused : false,
        };
        0x2::transfer::share_object<TokenConfig>(v4);
        let v5 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<OwnerCap>(v5, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZTEQ_TOKEN>>(v3, v0);
    }

    public fun is_paused(arg0: &TokenConfig) : bool {
        arg0.paused
    }

    public entry fun merge(arg0: &TokenConfig, arg1: &mut 0x2::coin::Coin<AZTEQ>, arg2: 0x2::coin::Coin<AZTEQ>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x2::coin::join<AZTEQ>(arg1, arg2);
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

