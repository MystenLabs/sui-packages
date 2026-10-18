module 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits {
    struct HASHBITS has drop {
        dummy_field: bool,
    }

    struct Hashbit has store, key {
        id: 0x2::object::UID,
        number: u64,
        traits: u64,
    }

    struct SetupCap has store, key {
        id: 0x2::object::UID,
    }

    struct Tier has copy, drop, store {
        size: u64,
        count: u64,
        price: u64,
        target: u128,
    }

    struct Streak has copy, drop, store {
        level: u8,
        time: u64,
    }

    struct Mint has key {
        id: 0x2::object::UID,
        treasury: address,
        anchor: vector<u8>,
        opened: bool,
        tiers: vector<Tier>,
        minted: u64,
        by_traits: 0x2::table::Table<u64, 0x2::object::ID>,
        streaks: 0x2::table::Table<address, Streak>,
    }

    struct Minted has copy, drop {
        id: 0x2::object::ID,
        number: u64,
        traits: u64,
        tier: u8,
        miner: address,
        price: u64,
    }

    struct Opened has copy, drop {
        anchor: vector<u8>,
    }

    public fun anchor(arg0: &Mint) : vector<u8> {
        arg0.anchor
    }

    public fun exists_traits(arg0: &Mint, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::object::ID>(&arg0.by_traits, arg1)
    }

    public fun hash_prefix(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: HASHBITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HASHBITS>(arg0, arg1);
        let v1 = 0x2::display::new<Hashbit>(&v0, arg1);
        0x2::display::add<Hashbit>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Hashbit #{number}"));
        0x2::display::add<Hashbit>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Every Hashbit is mined on chain and drawn on chain. Its picture comes from hashbits::render."));
        0x2::display::add<Hashbit>(&mut v1, 0x1::string::utf8(b"traits"), 0x1::string::utf8(b"{traits}"));
        0x2::display::add<Hashbit>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://api.hashbits.fun/img/{traits}.png"));
        0x2::display::add<Hashbit>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://hashbits.fun"));
        0x2::display::update_version<Hashbit>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Hashbit>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Hashbit>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Hashbit>>(v1, v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Hashbit>>(v3, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v4);
        let v5 = SetupCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SetupCap>(v5, v4);
        0x2::transfer::share_object<Mint>(new_mint(v4, arg1));
    }

    public fun mint(arg0: &mut Mint, arg1: u8, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Hashbit {
        assert!(arg0.opened, 13906835711942000646);
        let v0 = (arg1 as u64);
        assert!(v0 < 11, 13906835720532459534);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<Tier>(&arg0.tiers, v1);
            assert!(v2.count >= v2.size, 13906835742007427088);
            v1 = v1 + 1;
        };
        let v3 = *0x1::vector::borrow<Tier>(&arg0.tiers, v0);
        assert!(v3.count < v3.size, 13906835759187427346);
        assert!(v3.price <= arg4, 13906835763482787864);
        let v4 = 0x2::tx_context::sender(arg6);
        let v5 = work(v4, arg0.anchor, arg2);
        let v6 = 0x2::clock::timestamp_ms(arg5);
        let v7 = if (0x2::table::contains<address, Streak>(&arg0.streaks, v4)) {
            *0x2::table::borrow<address, Streak>(&arg0.streaks, v4)
        } else {
            Streak{level: 0, time: 0}
        };
        let v8 = v7;
        let v9 = (v6 - v8.time) / 30000;
        let v10 = if ((v8.level as u64) > v9) {
            v8.level - (v9 as u8)
        } else {
            0
        };
        assert!((hash_prefix(&v5) as u128) << v10 < v3.target, 13906835815022133268);
        let v11 = if (v10 < 12) {
            v10 + 1
        } else {
            12
        };
        let v12 = Streak{
            level : v11,
            time  : v6,
        };
        if (0x2::table::contains<address, Streak>(&arg0.streaks, v4)) {
            *0x2::table::borrow_mut<address, Streak>(&mut arg0.streaks, v4) = v12;
        } else {
            0x2::table::add<address, Streak>(&mut arg0.streaks, v4, v12);
        };
        let v13 = traits_from(&v5);
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg0.by_traits, v13), 13906835845087035414);
        if (v3.price > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v3.price, arg6), arg0.treasury);
        };
        0x1::vector::borrow_mut<Tier>(&mut arg0.tiers, v0).count = v3.count + 1;
        arg0.minted = arg0.minted + 1;
        let v14 = Hashbit{
            id     : 0x2::object::new(arg6),
            number : arg0.minted,
            traits : v13,
        };
        let v15 = 0x2::object::id<Hashbit>(&v14);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.by_traits, v13, v15);
        let v16 = Minted{
            id     : v15,
            number : v14.number,
            traits : v13,
            tier   : arg1,
            miner  : v4,
            price  : v3.price,
        };
        0x2::event::emit<Minted>(v16);
        v14
    }

    public fun minted(arg0: &Mint) : u64 {
        arg0.minted
    }

    fun new_mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Mint {
        let v0 = 0x1::vector::empty<Tier>();
        let v1 = &mut v0;
        0x1::vector::push_back<Tier>(v1, tier(50, 0, 512));
        0x1::vector::push_back<Tier>(v1, tier(550, 140, 512));
        0x1::vector::push_back<Tier>(v1, tier(550, 165, 445));
        0x1::vector::push_back<Tier>(v1, tier(550, 190, 387));
        0x1::vector::push_back<Tier>(v1, tier(550, 215, 337));
        0x1::vector::push_back<Tier>(v1, tier(550, 240, 293));
        0x1::vector::push_back<Tier>(v1, tier(550, 265, 255));
        0x1::vector::push_back<Tier>(v1, tier(550, 290, 222));
        0x1::vector::push_back<Tier>(v1, tier(550, 315, 193));
        0x1::vector::push_back<Tier>(v1, tier(523, 340, 168));
        0x1::vector::push_back<Tier>(v1, tier(582, 365, 146));
        Mint{
            id        : 0x2::object::new(arg1),
            treasury  : arg0,
            anchor    : b"",
            opened    : false,
            tiers     : v0,
            minted    : 0,
            by_traits : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            streaks   : 0x2::table::new<address, Streak>(arg1),
        }
    }

    public fun number(arg0: &Hashbit) : u64 {
        arg0.number
    }

    entry fun open(arg0: &SetupCap, arg1: &mut Mint, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        open_with(arg1, 0x2::random::generate_bytes(&mut v0, 32));
    }

    fun open_with(arg0: &mut Mint, arg1: vector<u8>) {
        assert!(!arg0.opened, 13906835346869911560);
        let v0 = 0;
        let v1 = &arg0.tiers;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Tier>(v1)) {
            let v3 = 0x1::vector::borrow<Tier>(v1, v2);
            assert!(v3.target > 0, 13906835359755075596);
            v0 = v0 + v3.size;
            v2 = v2 + 1;
        };
        assert!(v0 == 5555, 13906835372639846410);
        arg0.anchor = arg1;
        arg0.opened = true;
        let v4 = Opened{anchor: arg0.anchor};
        0x2::event::emit<Opened>(v4);
    }

    public fun opened(arg0: &Mint) : bool {
        arg0.opened
    }

    fun pick(arg0: u8, arg1: vector<u16>) : u64 {
        let v0 = 0;
        0x1::vector::reverse<u16>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg1)) {
            if ((arg0 as u16) >= 0x1::vector::pop_back<u16>(&mut arg1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg1);
        v0
    }

    public fun set_tier(arg0: &SetupCap, arg1: &mut Mint, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        assert!(!arg1.opened, 13906835243790696456);
        assert!((arg2 as u64) < 11, 13906835248086056974);
        let v0 = 0x1::vector::borrow_mut<Tier>(&mut arg1.tiers, (arg2 as u64));
        v0.size = arg3;
        v0.price = arg4;
        v0.target = (arg5 as u128) << 28;
    }

    public fun set_treasury(arg0: &SetupCap, arg1: &mut Mint, arg2: address) {
        assert!(!arg1.opened, 13906835286740369416);
        arg1.treasury = arg2;
    }

    public fun streak_level(arg0: &Mint, arg1: address, arg2: u64) : u8 {
        if (!0x2::table::contains<address, Streak>(&arg0.streaks, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Streak>(&arg0.streaks, arg1);
        let v1 = (arg2 - v0.time) / 30000;
        if ((v0.level as u64) > v1) {
            v0.level - (v1 as u8)
        } else {
            0
        }
    }

    fun tier(arg0: u64, arg1: u64, arg2: u64) : Tier {
        Tier{
            size   : arg0,
            count  : 0,
            price  : arg1 * 1000000000 / 100,
            target : (arg2 as u128) << 28,
        }
    }

    public fun tier_info(arg0: &Mint, arg1: u8) : (u64, u64, u64, u128) {
        let v0 = 0x1::vector::borrow<Tier>(&arg0.tiers, (arg1 as u64));
        (v0.size, v0.count, v0.price, v0.target)
    }

    public fun traits(arg0: &Hashbit) : u64 {
        arg0.traits
    }

    public fun traits_from(arg0: &vector<u8>) : u64 {
        let v0 = pick(*0x1::vector::borrow<u8>(arg0, 25), vector[51, 97, 138, 174, 205, 230, 256, 256, 256]);
        let v1 = pick(*0x1::vector::borrow<u8>(arg0, 27), vector[71, 122, 153, 184, 210, 236, 256, 256, 256]);
        let v2 = pick(*0x1::vector::borrow<u8>(arg0, 28), vector[36, 72, 100, 128, 156, 182, 208, 231, 249]);
        let v3 = pick(*0x1::vector::borrow<u8>(arg0, 29), vector[36, 77, 92, 107, 130, 161, 176, 199, 230]);
        let v4 = pick(*0x1::vector::borrow<u8>(arg0, 30), vector[61, 112, 158, 199, 230, 256, 256, 256, 256]);
        let v5 = if (v0 == 6) {
            6
        } else {
            pick(*0x1::vector::borrow<u8>(arg0, 26), vector[56, 102, 143, 179, 210, 236, 256, 256, 256])
        };
        let v6 = if (v3 == v2) {
            if (v3 == 9) {
                0
            } else {
                v3 + 1
            }
        } else {
            v3
        };
        let v7 = if (v2 == 9 && v4 == 5) {
            1
        } else {
            v4
        };
        let v8 = if (v0 == 5 && v1 == 6) {
            1
        } else {
            v1
        };
        pick(*0x1::vector::borrow<u8>(arg0, 24), vector[66, 127, 168, 209, 235, 256, 256, 256, 256]) | v0 << 4 | v5 << 8 | v8 << 12 | v2 << 16 | v6 << 20 | v7 << 24 | pick(*0x1::vector::borrow<u8>(arg0, 31), vector[67, 128, 174, 220, 256, 256, 256, 256, 256]) << 28
    }

    public fun treasury(arg0: &Mint) : address {
        arg0.treasury
    }

    public fun work(arg0: address, arg1: vector<u8>, arg2: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = 0x2::bcs::to_bytes<u64>(&arg2);
        while (0x1::vector::length<u8>(&v1) < 32) {
            0x1::vector::push_back<u8>(&mut v1, 0);
        };
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::hash::sha2_256(v0)
    }

    // decompiled from Move bytecode v7
}

