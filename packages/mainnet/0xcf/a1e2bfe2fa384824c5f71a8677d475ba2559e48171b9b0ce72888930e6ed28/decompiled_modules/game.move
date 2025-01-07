module 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::game {
    struct GameGlobal has key {
        id: 0x2::object::UID,
        version: u64,
        epoch: u64,
        round: u64,
        status: u8,
        pixel_count: u64,
        round_start_time: u64,
        round_duration: u64,
        destroy_duration: u64,
        last_win_pixel: 0x1::option::Option<0x1::string::String>,
        last_destroy_pixel: 0x1::option::Option<0x1::string::String>,
        last_lucky_pixel: 0x1::option::Option<0x1::string::String>,
    }

    public fun buy<T0>(arg0: &mut GameGlobal, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_game_end(arg0, arg1, arg3);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::buy<T0>(arg1, arg2, arg4)
    }

    fun check_game_end(arg0: &mut GameGlobal, arg1: &0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg2) >= arg0.round_start_time + arg0.round_duration && arg0.status == 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::game_round_status_playing()) {
            arg0.status = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::game_round_status_end();
            arg0.last_win_pixel = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::get_winner_pixel(arg1);
        };
    }

    fun check_game_time(arg0: &GameGlobal, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::game_round_status_playing() && arg0.round_start_time + arg0.round_duration > 0x2::clock::timestamp_ms(arg1), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_game_status());
    }

    public fun decorate<T0>(arg0: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::decorate_pixel<T0>(arg0, arg1, arg2, arg3)
    }

    public fun destroy<T0, T1, T2>(arg0: &mut GameGlobal, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_game_end(arg0, arg1, arg2);
        assert!(arg0.status == 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::game_round_status_end(), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_game_status());
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        let v1 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T1>();
        let v2 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T2>();
        arg0.last_destroy_pixel = 0x1::option::some<0x1::string::String>(v1);
        arg0.last_lucky_pixel = 0x1::option::some<0x1::string::String>(v2);
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.last_win_pixel) && 0x1::option::some<0x1::string::String>(v0) == arg0.last_win_pixel, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_win_pixel());
        assert!(arg0.last_win_pixel != arg0.last_destroy_pixel, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_destroy_pixel());
        let v3 = arg0.pixel_count - arg0.round;
        assert!(v3 >= 2 && arg0.last_lucky_pixel != arg0.last_win_pixel && arg0.last_lucky_pixel != arg0.last_destroy_pixel || v3 == 1 && arg0.last_lucky_pixel != arg0.last_win_pixel && arg0.last_lucky_pixel == arg0.last_destroy_pixel, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_lucky_pixel());
        let v4 = 0x2::clock::timestamp_ms(arg2);
        if (v4 <= arg0.round_start_time + arg0.round_duration + arg0.destroy_duration) {
            assert!(0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::get_pixel_leader<T0>(arg1) == 0x1::option::some<address>(0x2::tx_context::sender(arg3)), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::you_are_not_leader());
        };
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::destroy_pixel<T0, T1, T2>(arg1, v0, v1, v2, arg3);
        assert!(arg0.status == 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::game_round_status_end(), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_game_status());
        if (arg0.round == arg0.pixel_count - 1) {
            arg0.epoch = arg0.epoch + 1;
        };
        arg0.round = arg0.round + 1;
        assert!(arg0.round + 1 == arg0.pixel_count, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_game_round());
        arg0.round_start_time = v4;
        arg0.status = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::game_round_status_playing();
    }

    public(friend) fun init_game(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameGlobal{
            id                 : 0x2::object::new(arg0),
            version            : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::version::current_version(),
            epoch              : 0,
            round              : 0,
            status             : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::game_round_status_pending(),
            pixel_count        : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::pixel_count(),
            round_start_time   : 0,
            round_duration     : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::round_duration(),
            destroy_duration   : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::destroy_duration(),
            last_win_pixel     : 0x1::option::none<0x1::string::String>(),
            last_destroy_pixel : 0x1::option::none<0x1::string::String>(),
            last_lucky_pixel   : 0x1::option::none<0x1::string::String>(),
        };
        0x2::transfer::share_object<GameGlobal>(v0);
    }

    public fun join_alliance<T0, T1>(arg0: &GameGlobal, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_game_time(arg0, arg2);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::join_alliance<T0, T1>(arg1, arg3);
    }

    public fun leave_alliance<T0, T1>(arg0: &GameGlobal, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_game_time(arg0, arg2);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::leave_alliance<T0, T1>(arg1, arg3);
    }

    public fun list<T0>(arg0: &GameGlobal, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::list<T0>(arg1, arg2, arg3, arg4, arg5, arg0.pixel_count, arg6)
    }

    public fun sell<T0>(arg0: &mut GameGlobal, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_game_end(arg0, arg1, arg3);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::sell<T0>(arg1, arg2, arg4)
    }

    public fun stake<T0>(arg0: &mut GameGlobal, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_game_end(arg0, arg1, arg3);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::stake<T0>(arg1, arg2, arg4);
    }

    public(friend) fun start_game(arg0: &mut GameGlobal, arg1: &0x2::clock::Clock) {
        arg0.epoch = 1;
        arg0.round = 1;
        arg0.status = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::game_round_status_playing();
        arg0.round_start_time = 0x2::clock::timestamp_ms(arg1);
    }

    public fun unstake<T0>(arg0: &mut GameGlobal, arg1: &mut 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::PixelGlobal, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_game_end(arg0, arg1, arg3);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel::unstake<T0>(arg1, arg2, arg4)
    }

    public(friend) fun update_pixel_count(arg0: &mut GameGlobal, arg1: u64) {
        assert!(arg1 > 0 && arg0.round < arg1, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_pixel_count());
        arg0.pixel_count = arg1;
    }

    public(friend) fun update_round_duration(arg0: &mut GameGlobal, arg1: u64) {
        assert!(arg1 > 0, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_round_duration());
        arg0.round_duration = arg1;
    }

    // decompiled from Move bytecode v6
}

