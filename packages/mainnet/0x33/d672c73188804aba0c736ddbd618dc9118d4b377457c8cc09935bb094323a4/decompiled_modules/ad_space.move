module 0x33d672c73188804aba0c736ddbd618dc9118d4b377457c8cc09935bb094323a4::ad_space {
    struct AdSpace has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        location: 0x1::string::String,
        size: 0x1::string::String,
        is_available: bool,
        creator: address,
        created_at: u64,
        fixed_price: u64,
    }

    struct AdSpaceCreated has copy, drop {
        ad_space_id: 0x2::object::ID,
        game_id: 0x1::string::String,
        location: 0x1::string::String,
        size: 0x1::string::String,
        creator: address,
    }

    struct AdSpacePriceUpdated has copy, drop {
        ad_space_id: 0x2::object::ID,
        new_price: u64,
        updated_by: address,
    }

    struct AdSpaceAvailabilityUpdated has copy, drop {
        ad_space_id: 0x2::object::ID,
        is_available: bool,
        updated_by: address,
    }

    struct AdSpaceDeleted has copy, drop {
        ad_space_id: 0x2::object::ID,
        deleted_by: address,
    }

    public fun calculate_lease_price(arg0: &AdSpace, arg1: u64) : u64 {
        assert!(arg1 > 0 && arg1 <= 365, 3);
        let v0 = arg0.fixed_price;
        let v1 = 1000000;
        let v2 = 500000;
        if (arg1 == 1) {
            return v0
        };
        let v3 = v0;
        let v4 = v1;
        let v5 = 1;
        while (v5 < arg1) {
            v4 = v4 * 977000 / v1;
            if (v4 < v2) {
                v3 = v3 + v0 * v2 * (arg1 - v5) / v1;
                break
            };
            v3 = v3 + v0 * v4 / v1;
            v5 = v5 + 1;
        };
        v3
    }

    public fun create_ad_space(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AdSpace {
        let v0 = *0x1::string::as_bytes(&arg2);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v2) == 58) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 4);
        let v3 = AdSpace{
            id           : 0x2::object::new(arg6),
            game_id      : arg0,
            location     : arg1,
            size         : arg2,
            is_available : true,
            creator      : arg4,
            created_at   : 0x2::clock::timestamp_ms(arg5) / 1000,
            fixed_price  : arg3,
        };
        let v4 = AdSpaceCreated{
            ad_space_id : 0x2::object::id<AdSpace>(&v3),
            game_id     : arg0,
            location    : arg1,
            size        : arg2,
            creator     : arg4,
        };
        0x2::event::emit<AdSpaceCreated>(v4);
        v3
    }

    public fun delete_ad_space(arg0: AdSpace, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        let v0 = AdSpaceDeleted{
            ad_space_id : 0x2::object::id<AdSpace>(&arg0),
            deleted_by  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AdSpaceDeleted>(v0);
        let AdSpace {
            id           : v1,
            game_id      : _,
            location     : _,
            size         : _,
            is_available : _,
            creator      : _,
            created_at   : _,
            fixed_price  : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun get_creator(arg0: &AdSpace) : address {
        arg0.creator
    }

    public fun get_fixed_price(arg0: &AdSpace) : u64 {
        arg0.fixed_price
    }

    public fun get_game_id(arg0: &AdSpace) : 0x1::string::String {
        arg0.game_id
    }

    public fun get_metadata(arg0: &AdSpace) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.game_id, arg0.location, arg0.size)
    }

    public fun get_uid(arg0: &AdSpace) : &0x2::object::UID {
        &arg0.id
    }

    public fun is_available(arg0: &AdSpace) : bool {
        arg0.is_available
    }

    public fun set_availability(arg0: &mut AdSpace, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        arg0.is_available = arg1;
        let v0 = AdSpaceAvailabilityUpdated{
            ad_space_id  : 0x2::object::id<AdSpace>(arg0),
            is_available : arg1,
            updated_by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdSpaceAvailabilityUpdated>(v0);
    }

    public fun share_ad_space(arg0: AdSpace) {
        0x2::transfer::share_object<AdSpace>(arg0);
    }

    public fun update_price(arg0: &mut AdSpace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        arg0.fixed_price = arg1;
        let v0 = AdSpacePriceUpdated{
            ad_space_id : 0x2::object::id<AdSpace>(arg0),
            new_price   : arg1,
            updated_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdSpacePriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

