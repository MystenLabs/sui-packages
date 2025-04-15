module 0x607a90b2b91caab430d9aac2274e93daf098a296abf81a42efe88f46fade4d45::demo {
    struct DEMO has drop {
        dummy_field: bool,
    }

    public entry fun bag_add(arg0: &mut 0x2::bag::Bag, arg1: u32, arg2: u32) {
        0x2::bag::add<u32, u32>(arg0, arg1, arg2);
    }

    public entry fun bag_create(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::bag::Bag>(0x2::bag::new(arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun bag_destroy(arg0: 0x2::bag::Bag) {
        0x2::bag::destroy_empty(arg0);
    }

    public entry fun bag_remove(arg0: &mut 0x2::bag::Bag, arg1: u32) {
        0x2::bag::remove<u32, u32>(arg0, arg1);
    }

    fun init(arg0: DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO>(arg0, 6, b"HS", b"HelloSui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

