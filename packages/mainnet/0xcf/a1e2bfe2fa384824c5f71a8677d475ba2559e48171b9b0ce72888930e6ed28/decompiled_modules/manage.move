module 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::manage {
    public fun start_game(arg0: &0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::admin::AdminCap, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::game::GameGlobal, arg2: &0x2::clock::Clock) {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::game::start_game(arg1, arg2);
    }

    public fun update_pixel_count(arg0: &0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::admin::AdminCap, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::game::GameGlobal, arg2: u64) {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::game::update_pixel_count(arg1, arg2);
    }

    public fun update_round_duration(arg0: &0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::admin::AdminCap, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::game::GameGlobal, arg2: u64) {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::game::update_round_duration(arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::admin::init_admin(arg0);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::game::init_game(arg0);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::init_pixel(arg0);
    }

    public fun migrate<T0>(arg0: &0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::admin::AdminCap, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::migrate<T0>(arg1, arg2)
    }

    public fun update_decorate_fee(arg0: &0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::admin::AdminCap, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: u64) {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::update_decorate_fee(arg1, arg2);
    }

    public fun update_listing_fee(arg0: &0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::admin::AdminCap, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: u64) {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::update_listing_fee(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

