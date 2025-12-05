module 0x142eafe7e6e0297feda5c62fa4e784fc0d2e25ce1359e6d43c3761711c389ec5::chrono_capture {
    struct TimeVault has key {
        id: 0x2::object::UID,
        vault_name: 0x1::string::String,
        curator: address,
    }

    struct Moment has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        resolution_mp: u16,
        iso: u16,
        aperture: 0x1::string::String,
        shutter_speed: 0x1::string::String,
        likes: u32,
        for_sale: bool,
        price: u64,
    }

    public fun adjust_price(arg0: &mut Moment, arg1: u64) {
        assert!(arg0.for_sale, 0);
        arg0.price = arg1;
    }

    public fun capture_moment(arg0: 0x1::string::String, arg1: u16, arg2: u16, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Moment{
            id            : 0x2::object::new(arg5),
            title         : arg0,
            resolution_mp : arg1,
            iso           : arg2,
            aperture      : arg3,
            shutter_speed : arg4,
            likes         : 0,
            for_sale      : false,
            price         : 0,
        };
        0x2::transfer::transfer<Moment>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun create_vault(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeVault{
            id         : 0x2::object::new(arg1),
            vault_name : arg0,
            curator    : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<TimeVault>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun delist(arg0: &mut Moment) {
        arg0.for_sale = false;
        arg0.price = 0;
    }

    public fun get_likes(arg0: &Moment) : u32 {
        arg0.likes
    }

    public fun is_high_res(arg0: &Moment) : bool {
        arg0.resolution_mp >= 24
    }

    public fun is_trending(arg0: &Moment) : bool {
        arg0.likes > 100
    }

    public fun like_moment(arg0: &mut Moment) {
        arg0.likes = arg0.likes + 1;
    }

    public fun list_for_sale(arg0: &mut Moment, arg1: u64) {
        arg0.for_sale = true;
        arg0.price = arg1;
    }

    // decompiled from Move bytecode v6
}

