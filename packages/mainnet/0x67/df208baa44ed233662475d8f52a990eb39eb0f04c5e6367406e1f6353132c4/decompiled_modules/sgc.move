module 0x22d9b414bce0b0f9cc883734393fa20b741d266f460a0854fefbf3dd3ed1286e::sgc {
    struct SGC has drop {
        dummy_field: bool,
    }

    struct Halving_cycle has store, key {
        id: 0x2::object::UID,
        current: u64,
        remaining: u64,
        halved: u64,
    }

    struct AdminTotal has store, key {
        id: 0x2::object::UID,
        total: u64,
        cycle: u64,
    }

    struct Minter has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SGC>,
    }

    public entry fun admin_mint(arg0: &mut Minter, arg1: &mut AdminTotal, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (v0 >= arg1.cycle) {
            arg1.cycle = v0 + 30;
            arg1.total = arg1.total - 1000000000000000;
            0x2::coin::mint_and_transfer<SGC>(&mut arg0.cap, 1000000000000000, 0x2::tx_context::sender(arg2), arg2);
        };
    }

    public entry fun burn(arg0: 0x2::coin::Coin<SGC>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SGC>>(arg0, @0x0);
    }

    fun halved(arg0: u64, arg1: &mut Halving_cycle) {
        if (arg0 >= arg1.remaining) {
            arg1.halved = arg1.halved * 2;
            arg1.current = 100000000000000000 - arg1.remaining;
            arg1.remaining = arg1.current / 5 + arg1.remaining;
        };
    }

    fun init(arg0: SGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGC>(arg0, 6, b"SGC", b"SavingsGameCoin", b"Play the savings game and get Coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie5pwb2rcn7fz6sf76ex7hnclrnoblhk3qz33ssrcr3zaer52o5eu")), arg1);
        let v2 = AdminTotal{
            id    : 0x2::object::new(arg1),
            total : 25000000000000000,
            cycle : 0,
        };
        let v3 = Halving_cycle{
            id        : 0x2::object::new(arg1),
            current   : 100000000000000000,
            remaining : 100000000000000000 / 5,
            halved    : 1,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGC>>(v1);
        let v4 = Minter{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<Minter>(v4);
        0x2::transfer::public_share_object<Halving_cycle>(v3);
        0x2::transfer::transfer<AdminTotal>(v2, @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44);
    }

    public(friend) fun mint(arg0: &mut Minter, arg1: &mut Halving_cycle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::total_supply<SGC>(&mut arg0.cap);
        halved(v0, arg1);
        let v1 = arg2 / arg1.halved;
        if (v0 < 100000000000000000 && v1 > 0) {
            0x2::coin::mint_and_transfer<SGC>(&mut arg0.cap, v1, 0x2::tx_context::sender(arg3), arg3);
        };
    }

    // decompiled from Move bytecode v6
}

