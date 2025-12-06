module 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt {
    struct UserProfile has key {
        id: 0x2::object::UID,
        user: address,
        level: u64,
        points: u64,
        total_points: u64,
    }

    struct ItemInfo has copy, drop, store {
        name: 0x1::string::String,
        required_level: u64,
        point_cost: u64,
        rate: u64,
    }

    struct Shop has key {
        id: 0x2::object::UID,
        items: vector<ItemInfo>,
    }

    struct Event_lvup has copy, drop {
        user: address,
        new_level: u64,
    }

    entry fun add_item(arg0: &mut Shop, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::AdminCap, arg6: u64) {
        let v0 = ItemInfo{
            name           : arg1,
            required_level : arg2,
            point_cost     : arg3,
            rate           : arg4,
        };
        0x1::vector::insert<ItemInfo>(&mut arg0.items, v0, arg6);
    }

    fun add_item_in(arg0: &mut Shop, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ItemInfo{
            name           : arg1,
            required_level : arg2,
            point_cost     : arg3,
            rate           : arg4,
        };
        0x1::vector::push_back<ItemInfo>(&mut arg0.items, v0);
    }

    public(friend) fun add_user_points(arg0: &mut UserProfile, arg1: u64) {
        arg0.points = arg0.points + arg1;
        arg0.total_points = arg0.total_points + arg1;
    }

    public(friend) fun deduct_user_points(arg0: &mut UserProfile, arg1: u64) {
        arg0.points = arg0.points - arg1;
    }

    public fun get_user_level(arg0: &UserProfile) : u64 {
        arg0.level
    }

    public fun get_user_points(arg0: &UserProfile) : u64 {
        arg0.points
    }

    public fun get_user_total_points(arg0: &UserProfile) : u64 {
        arg0.total_points
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Shop{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<ItemInfo>(),
        };
        let v1 = &mut v0;
        add_item_in(v1, 0x1::string::utf8(b"bomb"), 5, 100, 2);
        0x2::transfer::share_object<Shop>(v0);
    }

    public fun item_cost(arg0: &Shop, arg1: u64) : u64 {
        0x1::vector::borrow<ItemInfo>(&arg0.items, arg1).point_cost
    }

    public fun item_limit_rate(arg0: &Shop, arg1: u64) : u64 {
        0x1::vector::borrow<ItemInfo>(&arg0.items, arg1).rate
    }

    public fun item_name(arg0: &Shop, arg1: u64) : 0x1::string::String {
        0x1::vector::borrow<ItemInfo>(&arg0.items, arg1).name
    }

    public fun item_name2index(arg0: &Shop, arg1: 0x1::string::String) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ItemInfo>(&arg0.items)) {
            if (0x1::vector::borrow<ItemInfo>(&arg0.items, v0).name == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public fun item_req_lv(arg0: &Shop, arg1: u64) : u64 {
        0x1::vector::borrow<ItemInfo>(&arg0.items, arg1).required_level
    }

    entry fun mint_user_profile(arg0: &mut Shop, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserProfile{
            id           : 0x2::derived_object::claim<address>(&mut arg0.id, 0x2::tx_context::sender(arg1)),
            user         : 0x2::tx_context::sender(arg1),
            level        : 1,
            points       : 0,
            total_points : 0,
        };
        0x2::transfer::transfer<UserProfile>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun remove_item(arg0: &mut Shop, arg1: &0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::AdminCap, arg2: u64) {
        0x1::vector::remove<ItemInfo>(&mut arg0.items, arg2);
    }

    entry fun remove_item_from_name(arg0: &mut Shop, arg1: &0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::AdminCap, arg2: 0x1::string::String) {
        0x1::vector::remove<ItemInfo>(&mut arg0.items, item_name2index(arg0, arg2));
    }

    public fun user_get_exp(arg0: &mut UserProfile, arg1: 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::Experience) {
        add_user_points(arg0, 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::exp_points(&arg1));
    }

    entry fun user_level_up(arg0: &mut UserProfile) {
        let v0 = arg0.level * arg0.level * 80;
        deduct_user_points(arg0, v0);
        arg0.level = arg0.level + 1;
        let v1 = Event_lvup{
            user      : arg0.user,
            new_level : arg0.level,
        };
        0x2::event::emit<Event_lvup>(v1);
    }

    // decompiled from Move bytecode v6
}

