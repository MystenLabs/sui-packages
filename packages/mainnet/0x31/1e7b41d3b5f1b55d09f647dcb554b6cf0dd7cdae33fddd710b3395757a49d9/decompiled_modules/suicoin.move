module 0x311e7b41d3b5f1b55d09f647dcb554b6cf0dd7cdae33fddd710b3395757a49d9::suicoin {
    struct SUICOIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseState has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICOIN>, arg1: 0x2::coin::Coin<SUICOIN>) {
        0x2::coin::burn<SUICOIN>(arg0, arg1);
    }

    public fun transfer(arg0: 0x2::coin::Coin<SUICOIN>, arg1: address, arg2: &PauseState) {
        assert!(!arg2.is_paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICOIN>>(arg0, arg1);
    }

    fun init(arg0: SUICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOIN>(arg0, 9, b"SUICOIN", b"SUICOIN", b"Custom SUI Token: SUICOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/sui-sui-logo.png?v=040")), arg1);
        let v2 = v0;
        let v3 = PauseState{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        0x2::transfer::share_object<PauseState>(v3);
        0x2::coin::mint_and_transfer<SUICOIN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICOIN>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SUICOIN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICOIN>(arg1, arg2, arg3, arg4);
    }

    public fun pause(arg0: &AdminCap, arg1: &mut PauseState) {
        arg1.is_paused = true;
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut PauseState) {
        arg1.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

