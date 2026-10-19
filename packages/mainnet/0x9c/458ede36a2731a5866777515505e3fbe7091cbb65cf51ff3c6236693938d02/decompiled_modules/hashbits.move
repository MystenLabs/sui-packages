module 0x9c458ede36a2731a5866777515505e3fbe7091cbb65cf51ff3c6236693938d02::hashbits {
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
        anchor: vector<u8>,
        opened: bool,
        tiers: vector<Tier>,
        minted: u64,
        v1_minted: u64,
        migrated: u64,
        by_traits: 0x2::table::Table<u64, 0x2::object::ID>,
        streaks: 0x2::table::Table<address, Streak>,
        per_wallet: 0x2::table::Table<address, u64>,
        last_ms: u64,
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
        v1_minted: u64,
    }

    struct Migrated has copy, drop {
        v1_id: 0x2::object::ID,
        id: 0x2::object::ID,
        number: u64,
        traits: u64,
        owner: address,
    }

    public fun exists_traits(arg0: &Mint, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::object::ID>(&arg0.by_traits, arg1)
    }

    public fun minted(arg0: &Mint) : u64 {
        arg0.minted
    }

    public fun number(arg0: &Hashbit) : u64 {
        arg0.number
    }

    public fun tier_info(arg0: &Mint, arg1: u8) : (u64, u64, u64, u128) {
        let v0 = 0x1::vector::borrow<Tier>(&arg0.tiers, (arg1 as u64));
        (v0.size, v0.count, v0.price, v0.target)
    }

    public fun traits(arg0: &Hashbit) : u64 {
        arg0.traits
    }

    public fun anchor(arg0: &Mint) : vector<u8> {
        arg0.anchor
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
        0x2::transfer::share_object<Mint>(new_mint(arg1));
    }

    public fun last_ms(arg0: &Mint) : u64 {
        arg0.last_ms
    }

    public fun migrate(arg0: &mut Mint, arg1: 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit, arg2: &mut 0x2::tx_context::TxContext) : Hashbit {
        assert!(arg0.opened, 13906836085604220935);
        let v0 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::number(&arg1);
        let v1 = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::traits(&arg1);
        assert!(v0 >= 1 && v0 <= arg0.v1_minted, 13906836098490302489);
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg0.by_traits, v1), 13906836107080106007);
        0x2::transfer::public_transfer<0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(arg1, @0x0);
        let v2 = Hashbit{
            id     : 0x2::object::new(arg2),
            number : v0,
            traits : v1,
        };
        let v3 = 0x2::object::id<Hashbit>(&v2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.by_traits, v1, v3);
        arg0.migrated = arg0.migrated + 1;
        let v4 = Migrated{
            v1_id  : 0x2::object::id<0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(&arg1),
            id     : v3,
            number : v0,
            traits : v1,
            owner  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Migrated>(v4);
        v2
    }

    public fun migrated(arg0: &Mint) : u64 {
        arg0.migrated
    }

    public fun mint(arg0: &mut Mint, arg1: &0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Mint, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Hashbit {
        assert!(arg0.opened, 13906835853675986951);
        let v0 = (arg2 as u64);
        assert!(v0 < 11, 13906835862266445839);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<Tier>(&arg0.tiers, v1);
            assert!(v2.count >= v2.size, 13906835883741413393);
            v1 = v1 + 1;
        };
        let v3 = *0x1::vector::borrow<Tier>(&arg0.tiers, v0);
        assert!(v3.count < v3.size, 13906835900921413651);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.last_ms == 0 || v5 >= arg0.last_ms + 5000, 13906835922396905501);
        let v6 = if (0x2::table::contains<address, u64>(&arg0.per_wallet, v4)) {
            *0x2::table::borrow<address, u64>(&arg0.per_wallet, v4)
        } else {
            0
        };
        assert!(v6 < 3, 13906835930986709019);
        let v7 = work(v4, arg0.anchor, arg3);
        let v8 = if (0x2::table::contains<address, Streak>(&arg0.streaks, v4)) {
            *0x2::table::borrow<address, Streak>(&arg0.streaks, v4)
        } else {
            Streak{level: 0, time: 0}
        };
        let v9 = v8;
        let v10 = (v5 - v9.time) / 30000;
        let v11 = if ((v9.level as u64) > v10) {
            v9.level - (v10 as u8)
        } else {
            0
        };
        assert!((hash_prefix(&v7) as u128) << v11 < v3.target, 13906835973935988757);
        let v12 = if (v11 < 12) {
            v11 + 1
        } else {
            12
        };
        let v13 = Streak{
            level : v12,
            time  : v5,
        };
        if (0x2::table::contains<address, Streak>(&arg0.streaks, v4)) {
            *0x2::table::borrow_mut<address, Streak>(&mut arg0.streaks, v4) = v13;
        } else {
            0x2::table::add<address, Streak>(&mut arg0.streaks, v4, v13);
        };
        let v14 = traits_from(&v7);
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg0.by_traits, v14), 13906836004000890903);
        assert!(!0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::exists_traits(arg1, v14), 13906836008295858199);
        0x1::vector::borrow_mut<Tier>(&mut arg0.tiers, v0).count = v3.count + 1;
        arg0.minted = arg0.minted + 1;
        arg0.last_ms = v5;
        if (v6 == 0) {
            0x2::table::add<address, u64>(&mut arg0.per_wallet, v4, 1);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.per_wallet, v4) = v6 + 1;
        };
        let v15 = Hashbit{
            id     : 0x2::object::new(arg5),
            number : arg0.minted,
            traits : v14,
        };
        let v16 = 0x2::object::id<Hashbit>(&v15);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.by_traits, v14, v16);
        let v17 = Minted{
            id     : v16,
            number : v15.number,
            traits : v14,
            tier   : arg2,
            miner  : v4,
            price  : 0,
        };
        0x2::event::emit<Minted>(v17);
        v15
    }

    public fun minted_by(arg0: &Mint, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.per_wallet, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.per_wallet, arg1)
        } else {
            0
        }
    }

    fun new_mint(arg0: &mut 0x2::tx_context::TxContext) : Mint {
        let v0 = 0x1::vector::empty<Tier>();
        let v1 = &mut v0;
        0x1::vector::push_back<Tier>(v1, tier(50, 512));
        0x1::vector::push_back<Tier>(v1, tier(550, 512));
        0x1::vector::push_back<Tier>(v1, tier(550, 445));
        0x1::vector::push_back<Tier>(v1, tier(550, 387));
        0x1::vector::push_back<Tier>(v1, tier(550, 337));
        0x1::vector::push_back<Tier>(v1, tier(550, 293));
        0x1::vector::push_back<Tier>(v1, tier(550, 255));
        0x1::vector::push_back<Tier>(v1, tier(550, 222));
        0x1::vector::push_back<Tier>(v1, tier(550, 193));
        0x1::vector::push_back<Tier>(v1, tier(523, 168));
        0x1::vector::push_back<Tier>(v1, tier(582, 146));
        Mint{
            id         : 0x2::object::new(arg0),
            anchor     : b"",
            opened     : false,
            tiers      : v0,
            minted     : 0,
            v1_minted  : 0,
            migrated   : 0,
            by_traits  : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            streaks    : 0x2::table::new<address, Streak>(arg0),
            per_wallet : 0x2::table::new<address, u64>(arg0),
            last_ms    : 0,
        }
    }

    entry fun open(arg0: &SetupCap, arg1: &mut Mint, arg2: &0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Mint, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg3, arg4);
        open_with(arg1, arg2, 0x2::random::generate_bytes(&mut v0, 32));
    }

    fun open_with(arg0: &mut Mint, arg1: &0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Mint, arg2: vector<u8>) {
        assert!(!arg0.opened, 13906835462834094089);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 11) {
            let (_, v3, _, _) = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::tier_info(arg1, (v1 as u8));
            let v6 = 0x1::vector::borrow_mut<Tier>(&mut arg0.tiers, v1);
            assert!(v6.target > 0, 13906835488604160013);
            assert!(v3 <= v6.size, 13906835492898996235);
            v6.count = v3;
            v0 = v0 + v6.size;
            v1 = v1 + 1;
        };
        assert!(v0 == 5555, 13906835514373832715);
        arg0.v1_minted = 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::minted(arg1);
        arg0.minted = arg0.v1_minted;
        arg0.anchor = arg2;
        arg0.opened = true;
        let v7 = Opened{
            anchor    : arg0.anchor,
            v1_minted : arg0.v1_minted,
        };
        0x2::event::emit<Opened>(v7);
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

    public fun set_tier(arg0: &SetupCap, arg1: &mut Mint, arg2: u8, arg3: u64, arg4: u64) {
        assert!(!arg1.opened, 13906835385524682761);
        assert!((arg2 as u64) < 11, 13906835389820043279);
        let v0 = 0x1::vector::borrow_mut<Tier>(&mut arg1.tiers, (arg2 as u64));
        v0.size = arg3;
        v0.target = (arg4 as u128) << 28;
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

    fun tier(arg0: u64, arg1: u64) : Tier {
        Tier{
            size   : arg0,
            count  : 0,
            price  : 0,
            target : (arg1 as u128) << 28,
        }
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

    public fun v1_minted(arg0: &Mint) : u64 {
        arg0.v1_minted
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

