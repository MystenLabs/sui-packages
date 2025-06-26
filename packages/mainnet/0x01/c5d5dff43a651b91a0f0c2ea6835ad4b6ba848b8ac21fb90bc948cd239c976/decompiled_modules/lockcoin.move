module 0x1c5d5dff43a651b91a0f0c2ea6835ad4b6ba848b8ac21fb90bc948cd239c976::lockcoin {
    struct LOCKCOIN has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        unlocked: bool,
        locked_pool: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOCKCOIN>, arg1: 0x2::coin::Coin<LOCKCOIN>) {
        0x2::coin::burn<LOCKCOIN>(arg0, arg1);
    }

    fun init(arg0: LOCKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKCOIN>(arg0, 9, b"LOCKCOIN", b"LOCKCOIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOCKCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKCOIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Config{
            id          : 0x2::object::new(arg1),
            admin       : 0x2::tx_context::sender(arg1),
            unlocked    : false,
            locked_pool : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOCKCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOCKCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun safe_transfer(arg0: &Config, arg1: 0x2::coin::Coin<LOCKCOIN>, arg2: address) {
        if (!arg0.unlocked) {
            assert!(arg2 != arg0.locked_pool, 1003);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LOCKCOIN>>(arg1, arg2);
    }

    public entry fun set_locked_pool(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1001);
        arg0.locked_pool = arg1;
    }

    public entry fun unlock(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1002);
        arg0.unlocked = true;
    }

    // decompiled from Move bytecode v6
}

