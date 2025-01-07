module 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::lucky_bag {
    struct LuckyBagDrawnEvent has copy, drop {
        drawer: address,
        stroke_count: u8,
    }

    struct DrawConfig has key {
        id: 0x2::object::UID,
        price: u64,
        version: u64,
    }

    fun draw(arg0: &0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::fu::FuFontConfig, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : vector<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke> {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 3);
        let v2 = 0x1::vector::empty<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>();
        let v3 = 0x2::random::generate_u8_in_range(&mut v0, 1, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::fu::max_fonts(arg0));
        let v4 = 0x2::random::new_generator(arg1, arg2);
        let v5 = 0;
        while (v5 < v1) {
            0x1::vector::push_back<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&mut v2, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::create(v3, 0x2::random::generate_u8_in_range(&mut v4, 1, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::fu::required_strokes(arg0, v3)), arg2));
            v5 = v5 + 1;
        };
        let v6 = LuckyBagDrawnEvent{
            drawer       : 0x2::tx_context::sender(arg2),
            stroke_count : v1,
        };
        0x2::event::emit<LuckyBagDrawnEvent>(v6);
        v2
    }

    entry fun draw_and_transfer(arg0: &DrawConfig, arg1: &0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::fu::FuFontConfig, arg2: &mut 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::Treasury, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::check_version(arg0.version);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.price, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::deposit(arg2, arg3, arg0.price, arg5), 0x2::tx_context::sender(arg5));
        let v0 = draw(arg1, arg4, arg5);
        while (!0x1::vector::is_empty<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&v0)) {
            0x2::transfer::public_transfer<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(0x1::vector::pop_back<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&mut v0), 0x2::tx_context::sender(arg5));
        };
        0x1::vector::destroy_empty<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DrawConfig{
            id      : 0x2::object::new(arg0),
            price   : 1000000000,
            version : 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::version(),
        };
        0x2::transfer::share_object<DrawConfig>(v0);
    }

    public(friend) fun migrate(arg0: &mut DrawConfig) {
        arg0.version = 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::version();
    }

    public fun price(arg0: &DrawConfig) : u64 {
        arg0.price
    }

    public(friend) fun set_price(arg0: &mut DrawConfig, arg1: u64) {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::check_version(arg0.version);
        arg0.price = arg1;
    }

    // decompiled from Move bytecode v6
}

