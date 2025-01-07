module 0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::ryubox {
    struct RYUBOXNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        number: u64,
        img_url: 0x2::url::Url,
        link: 0x2::url::Url,
        description: 0x1::string::String,
        creator: 0x1::string::String,
    }

    struct RyuBoxCollect has store, key {
        id: 0x2::object::UID,
        number: u64,
        consumes_fragment: u64,
        close_mint_time: u64,
        open_time: u64,
        limit_box: u64,
    }

    struct RyuBoxSum has key {
        id: 0x2::object::UID,
        total_reward_ryu: u64,
        total_reward_sui: u64,
        total_reffer_power: u64,
        claimed_reward_ryu: u64,
        claimed_reward_sui: u64,
        claimed_reffer_power: u64,
    }

    struct BoxReward has store {
        reward_ryu: u64,
        reward_sui: u64,
        reward_reffer_power: u64,
    }

    struct RYUBOX has drop {
        dummy_field: bool,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        addr: address,
        number: u64,
    }

    struct OpenBoxEvent has copy, drop {
        addr: address,
        number: u64,
        reward_ryu: u64,
        reward_sui: u64,
        reward_reffer_power: u64,
    }

    public entry fun add_wl(arg0: &mut RyuBoxCollect, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::dynamic_field::exists_<address>(&mut arg0.id, v1)) {
                0x2::dynamic_field::add<address, bool>(&mut arg0.id, v1, true);
            };
            v0 = 0x1::vector::length<address>(&arg1) - 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    fun burn_nft(arg0: RYUBOXNFT) {
        let RYUBOXNFT {
            id          : v0,
            name        : _,
            number      : _,
            img_url     : _,
            link        : _,
            description : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun can_claim(arg0: &mut RyuBoxCollect, arg1: address) : bool {
        if (0x2::dynamic_field::exists_<address>(&mut arg0.id, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, bool>(&mut arg0.id, arg1);
            if (*v0) {
                *v0 = false;
                return true
            };
        };
        false
    }

    fun get_current_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun init(arg0: RYUBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<RYUBOX>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}{number}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://ryu.finance"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b" Ryu Mystery Box "));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://ryu.finance"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://ryu.finance"));
        let v6 = 0x2::display::new_with_fields<RYUBOXNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<RYUBOXNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<RYUBOXNFT>>(v6, v0);
        let v7 = RyuBoxCollect{
            id                : 0x2::object::new(arg1),
            number            : 0,
            consumes_fragment : 10000000000,
            close_mint_time   : 1684918800,
            open_time         : 1684918800,
            limit_box         : 2000,
        };
        0x2::transfer::public_share_object<RyuBoxCollect>(v7);
        let v8 = RyuBoxSum{
            id                   : 0x2::object::new(arg1),
            total_reward_ryu     : 0,
            total_reward_sui     : 0,
            total_reffer_power   : 0,
            claimed_reward_ryu   : 0,
            claimed_reward_sui   : 0,
            claimed_reffer_power : 0,
        };
        0x2::transfer::share_object<RyuBoxSum>(v8);
    }

    public entry fun inject_reward(arg0: &mut RyuBoxSum, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        let v0 = 0x1::vector::length<u64>(&mut arg1);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v2 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v3 = 0x1::vector::pop_back<u64>(&mut arg4);
            arg0.total_reward_ryu = arg0.total_reward_ryu + v1;
            arg0.total_reward_sui = arg0.total_reward_sui + v2;
            arg0.total_reffer_power = arg0.total_reffer_power + v3;
            let v4 = BoxReward{
                reward_ryu          : v1,
                reward_sui          : v2,
                reward_reffer_power : v3,
            };
            0x2::dynamic_field::add<u64, BoxReward>(&mut arg0.id, 0x1::vector::pop_back<u64>(&mut arg1), v4);
            v0 = v0 - 1;
        };
    }

    fun mint(arg0: &mut RyuBoxCollect, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.limit_box >= arg0.number, 1006);
        let v1 = RYUBOXNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Ryu Mystery Box #"),
            number      : arg0.number,
            img_url     : 0x2::url::new_unsafe_from_bytes(b"https://mystery-box.4everland.store/box.png"),
            link        : 0x2::url::new_unsafe_from_bytes(b"https://ryu.finance"),
            description : 0x1::string::utf8(b" Ryu Mystery Box"),
            creator     : 0x1::string::utf8(b"RyuFinance"),
        };
        arg0.number = arg0.number + 1;
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            addr      : v0,
            number    : v1.number,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<RYUBOXNFT>(v1, v0);
    }

    public entry fun mint_by_fragment(arg0: 0x2::coin::Coin<0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::fragment::FRAGMENT>, arg1: &mut 0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::fragment::FragmentInfo, arg2: &mut RyuBoxCollect, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(get_current_timestamp(arg3) < arg2.close_mint_time, 1004);
        let v1 = 0x2::coin::value<0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::fragment::FRAGMENT>(&arg0) / arg2.consumes_fragment;
        assert!(v1 > 0, 1005);
        0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::fragment::burn(arg1, 0x2::coin::split<0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::fragment::FRAGMENT>(&mut arg0, v1 * arg2.consumes_fragment, arg4));
        while (v1 > 0) {
            mint(arg2, arg4);
            v1 = v1 - 1;
        };
        if (0x2::coin::value<0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::fragment::FRAGMENT>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::fragment::FRAGMENT>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<0x3f0ca57e129eae63df3703d8eab3f8bad3c2ea276d31a01d790bce33a74f8ca::fragment::FRAGMENT>(arg0);
        };
    }

    public entry fun mint_by_wl(arg0: &mut RyuBoxCollect, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(can_claim(arg0, 0x2::tx_context::sender(arg2)), 1003);
        assert!(get_current_timestamp(arg1) < arg0.close_mint_time, 1004);
        mint(arg0, arg2);
    }

    public fun open_box(arg0: &mut RyuBoxCollect, arg1: &mut RyuBoxSum, arg2: &0x2::clock::Clock, arg3: RYUBOXNFT, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(get_current_timestamp(arg2) > arg0.open_time, 1002);
        let v0 = 0x2::dynamic_field::borrow<u64, BoxReward>(&mut arg1.id, arg3.number);
        let v1 = OpenBoxEvent{
            addr                : 0x2::tx_context::sender(arg4),
            number              : arg3.number,
            reward_ryu          : v0.reward_ryu,
            reward_sui          : v0.reward_sui,
            reward_reffer_power : v0.reward_reffer_power,
        };
        0x2::event::emit<OpenBoxEvent>(v1);
        burn_nft(arg3);
        arg1.claimed_reffer_power = arg1.claimed_reffer_power + v0.reward_reffer_power;
        arg1.claimed_reward_ryu = arg1.claimed_reward_ryu + v0.reward_ryu;
        arg1.claimed_reward_sui = arg1.claimed_reward_sui + v0.reward_sui;
        (v0.reward_reffer_power, v0.reward_ryu, v0.reward_sui)
    }

    public entry fun set_collect(arg0: &mut RyuBoxCollect, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1001);
        arg0.consumes_fragment = arg1;
        arg0.close_mint_time = arg2;
        arg0.open_time = arg3;
        arg0.limit_box = arg4;
    }

    // decompiled from Move bytecode v6
}

