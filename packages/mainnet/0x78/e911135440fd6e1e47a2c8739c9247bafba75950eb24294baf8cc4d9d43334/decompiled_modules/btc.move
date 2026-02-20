module 0x78e911135440fd6e1e47a2c8739c9247bafba75950eb24294baf8cc4d9d43334::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseState has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BTC>, arg1: 0x2::coin::Coin<BTC>) {
        0x2::coin::burn<BTC>(arg0, arg1);
    }

    public fun transfer(arg0: 0x2::coin::Coin<BTC>, arg1: address, arg2: &PauseState) {
        assert!(!arg2.is_paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTC>>(arg0, arg1);
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 9, b"BTC", b"Bitcoin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = PauseState{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        0x2::transfer::share_object<PauseState>(v3);
        0x2::coin::mint_and_transfer<BTC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<BTC>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTC>(arg1, arg2, arg3, arg4);
    }

    public fun pause(arg0: &AdminCap, arg1: &mut PauseState) {
        arg1.is_paused = true;
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut PauseState) {
        arg1.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

