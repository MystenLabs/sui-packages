module 0x5a7472cf607cce22edc53735975449f0de457bac0482f439a8a88eabd63742b9::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseState has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: 0x2::coin::Coin<USDC>) {
        0x2::coin::burn<USDC>(arg0, arg1);
    }

    public fun transfer(arg0: 0x2::coin::Coin<USDC>, arg1: address, arg2: &PauseState) {
        assert!(!arg2.is_paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(arg0, arg1);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 9, b"USDC", b"USDC", b"Custom SUI Token: USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.circle.com/hubfs/Brand/USDC/USDC_icon_32x32.png")), arg1);
        let v2 = v0;
        let v3 = PauseState{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        0x2::transfer::share_object<PauseState>(v3);
        0x2::coin::mint_and_transfer<USDC>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<USDC>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDC>(arg1, arg2, arg3, arg4);
    }

    public fun pause(arg0: &AdminCap, arg1: &mut PauseState) {
        arg1.is_paused = true;
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut PauseState) {
        arg1.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

