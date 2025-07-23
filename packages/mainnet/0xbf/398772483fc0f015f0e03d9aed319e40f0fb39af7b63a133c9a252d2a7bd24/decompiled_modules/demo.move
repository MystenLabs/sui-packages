module 0x52126499d944ac50bb35c291016d59d68bae45edff93906b3af703c5bc418433::demo {
    struct Counter has store, key {
        id: 0x2::object::UID,
        count: u32,
    }

    struct DEMO has drop {
        dummy_field: bool,
    }

    public entry fun coin_mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_counter(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::public_transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun destroy_counter(arg0: Counter, arg1: &mut 0x2::tx_context::TxContext) {
        let Counter {
            id    : v0,
            count : v1,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public entry fun increment_counter(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
    }

    fun init(arg0: DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO>(arg0, 6, b"DC", b"DemoCoin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun reset_counter(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.count = 0;
    }

    // decompiled from Move bytecode v6
}

