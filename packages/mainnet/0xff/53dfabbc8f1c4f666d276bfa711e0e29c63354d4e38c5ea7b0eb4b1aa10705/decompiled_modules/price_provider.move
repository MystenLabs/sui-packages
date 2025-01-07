module 0xff53dfabbc8f1c4f666d276bfa711e0e29c63354d4e38c5ea7b0eb4b1aa10705::price_provider {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct ProviderCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceFeed<phantom T0> has key {
        id: 0x2::object::UID,
        price: u128,
    }

    public fun create_price_feed<T0>(arg0: &ProviderCap, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceFeed<T0>{
            id    : 0x2::object::new(arg2),
            price : arg1,
        };
        0x2::transfer::share_object<PriceFeed<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProviderCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ProviderCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun update_cny_oracle<T0>(arg0: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::Oracle, arg1: &PriceFeed<T0>, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::update_price<T0, Rule>(v0, arg0, arg2, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::precision() * arg1.price / 1000000000);
    }

    public fun update_price_feed<T0>(arg0: &ProviderCap, arg1: &mut PriceFeed<T0>, arg2: u128) {
        arg1.price = arg2;
    }

    // decompiled from Move bytecode v6
}

