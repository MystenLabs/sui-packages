module 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::spring {
    struct SPRING has drop {
        dummy_field: bool,
    }

    struct Spring has key {
        id: 0x2::object::UID,
        live: vector<u64>,
        tiers: vector<u64>,
        minted: u64,
        melted: u64,
        fused: u64,
        locked: u64,
    }

    struct Droplet has store, key {
        id: 0x2::object::UID,
        serial: u64,
        tier: u8,
        rarity: u8,
        purity: u64,
        weight: u64,
        traits: u8,
        colors: u8,
        pure: bool,
        marbled: bool,
        trace: bool,
        upgrades: u8,
        lineage: vector<u64>,
        born_epoch: u64,
        name: 0x1::string::String,
        tier_name: 0x1::string::String,
        rarity_name: 0x1::string::String,
        held: 0x2::balance::Balance<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>,
    }

    struct Condensed has copy, drop {
        droplet: 0x2::object::ID,
        serial: u64,
        rarity: u8,
        traits: u8,
        owner: address,
    }

    struct Melted has copy, drop {
        droplet: 0x2::object::ID,
        serial: u64,
        tier: u8,
        rarity: u8,
        units: u64,
        owner: address,
    }

    struct Fused has copy, drop {
        droplet: 0x2::object::ID,
        serial: u64,
        tier: u8,
        rarity: u8,
        inputs: vector<u64>,
        input_rarities: vector<u8>,
        upgraded: bool,
        pure: bool,
        weight: u64,
        owner: address,
    }

    public fun colors(arg0: &Droplet) : u8 {
        arg0.colors
    }

    fun compose_name(arg0: u8, arg1: u8, arg2: u64) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let v0 = 0x1::string::utf8(0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::rarity_name(arg1));
        0x1::string::append_utf8(&mut v0, b" ");
        0x1::string::append(&mut v0, 0x1::string::utf8(0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::tier_name(arg0)));
        0x1::string::append_utf8(&mut v0, b" #");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg2));
        (v0, 0x1::string::utf8(0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::tier_name(arg0)), 0x1::string::utf8(0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::rarity_name(arg1)))
    }

    entry fun condense(arg0: &mut Spring, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>, arg3: &mut 0x2::tx_context::TxContext) {
        condense_many(arg0, arg1, arg2, 1, arg3);
    }

    entry fun condense_all(arg0: &mut Spring, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&arg2) / 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::one();
        let v1 = v0;
        assert!(v0 > 0, 13906835742006444033);
        if (v0 > 20) {
            v1 = 20;
        };
        condense_many(arg0, arg1, arg2, v1, arg3);
    }

    entry fun condense_many(arg0: &mut Spring, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 13906835595977818117);
        assert!(arg3 <= 20, 13906835600272916487);
        let v0 = 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::one();
        assert!(0x2::coin::value<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&arg2) >= v0 * arg3, 13906835608862457857);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0;
        while (v3 < arg3) {
            let v4 = &mut v1;
            let v5 = mint_one(arg0, v4, 0x2::balance::split<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(0x2::coin::balance_mut<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&mut arg2), v0), arg4);
            let v6 = Condensed{
                droplet : 0x2::object::id<Droplet>(&v5),
                serial  : v5.serial,
                rarity  : v5.rarity,
                traits  : v5.traits,
                owner   : v2,
            };
            0x2::event::emit<Condensed>(v6);
            0x2::transfer::public_transfer<Droplet>(v5, v2);
            v3 = v3 + 1;
        };
        if (0x2::coin::value<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>>(arg2, v2);
        };
    }

    fun do_fuse(arg0: &mut Spring, arg1: &mut 0x2::random::RandomGenerator, arg2: Droplet, arg3: Droplet, arg4: Droplet, arg5: &mut 0x2::tx_context::TxContext) : Droplet {
        assert!(arg2.tier == arg3.tier && arg3.tier == arg4.tier, 13906835978230169609);
        assert!(arg2.tier < 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::max_tier(), 13906835982525267979);
        let v0 = arg2.tier + 1;
        let v1 = arg2.rarity;
        let v2 = arg3.rarity;
        let v3 = arg4.rarity;
        let v4 = v1 == v2 && v2 == v3;
        let v5 = 0x2::random::generate_u8_in_range(arg1, 1, 100) <= 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::upgrade_pct(0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::rarest(v1, v2, v3), v4);
        let v6 = inherit_trait(arg2.traits, arg1);
        let v7 = inherit_trait(arg3.traits, arg1);
        let v8 = vector[];
        let v9 = 0x2::balance::zero<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>();
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        let v13 = false;
        let v14 = 0;
        let v15 = arg2.serial;
        let v16 = 0x1::vector::empty<u64>();
        let v17 = &mut v16;
        0x1::vector::push_back<u64>(v17, arg2.serial);
        0x1::vector::push_back<u64>(v17, arg3.serial);
        0x1::vector::push_back<u64>(v17, arg4.serial);
        let v18 = 0x1::vector::empty<u8>();
        let v19 = &mut v18;
        0x1::vector::push_back<u8>(v19, v1);
        0x1::vector::push_back<u8>(v19, v2);
        0x1::vector::push_back<u8>(v19, v3);
        let v20 = 0x1::vector::empty<Droplet>();
        let v21 = &mut v20;
        0x1::vector::push_back<Droplet>(v21, arg2);
        0x1::vector::push_back<Droplet>(v21, arg3);
        0x1::vector::push_back<Droplet>(v21, arg4);
        let v22 = 0;
        while (v22 < 3) {
            let Droplet {
                id          : v23,
                serial      : _,
                tier        : v25,
                rarity      : v26,
                purity      : v27,
                weight      : v28,
                traits      : _,
                colors      : v30,
                pure        : _,
                marbled     : _,
                trace       : v33,
                upgrades    : v34,
                lineage     : v35,
                born_epoch  : _,
                name        : _,
                tier_name   : _,
                rarity_name : _,
                held        : v40,
            } = 0x1::vector::remove<Droplet>(&mut v20, 0);
            let v41 = v40;
            give_slot(arg0, v26, v25, 0x2::balance::value<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&v41));
            v10 = v10 + v28;
            v11 = v11 + v27;
            v12 = v12 | v30;
            let v42 = if (v13) {
                true
            } else if (v33) {
                true
            } else {
                v26 == 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::prism()
            };
            v13 = v42;
            v14 = v14 + v34;
            0x1::vector::append<u64>(&mut v8, v35);
            0x2::balance::join<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&mut v9, v41);
            0x2::object::delete(v23);
            v22 = v22 + 1;
        };
        0x1::vector::destroy_empty<Droplet>(v20);
        let v43 = nearest_free(arg0, 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::resolve_rarity(v1, v2, v3, v5));
        let v44 = v43 > 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::resolve_rarity(v1, v2, v3, false);
        if (v44) {
            v14 = v14 + 1;
        };
        arg0.fused = arg0.fused + 1;
        take_slot(arg0, v43, v0, 0x2::balance::value<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&v9));
        let (v45, v46, v47) = compose_name(v0, v43, v15);
        let v48 = 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::fusion_weight(v10, v43, v44);
        let v49 = Droplet{
            id          : 0x2::object::new(arg5),
            serial      : v15,
            tier        : v0,
            rarity      : v43,
            purity      : v11,
            weight      : v48,
            traits      : v6 | v7 | inherit_trait(arg4.traits, arg1),
            colors      : v12 | 1 << v43,
            pure        : v4,
            marbled     : !v4,
            trace       : v13,
            upgrades    : v14,
            lineage     : v8,
            born_epoch  : 0x2::tx_context::epoch(arg5),
            name        : v45,
            tier_name   : v46,
            rarity_name : v47,
            held        : v9,
        };
        let v50 = Fused{
            droplet        : 0x2::object::id<Droplet>(&v49),
            serial         : v15,
            tier           : v0,
            rarity         : v43,
            inputs         : v16,
            input_rarities : v18,
            upgraded       : v44,
            pure           : v4,
            weight         : v48,
            owner          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Fused>(v50);
        v49
    }

    fun draw_rarity(arg0: &Spring, arg1: &mut 0x2::random::RandomGenerator) : u8 {
        let v0 = free_total(arg0);
        assert!(v0 > 0, 13906835170775924739);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = false;
        while (v2 < 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::n_rarities()) {
            let v5 = v1 + 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::cap_of((v2 as u8)) - *0x1::vector::borrow<u64>(&arg0.live, v2);
            v1 = v5;
            if (!v4 && 0x2::random::generate_u64_in_range(arg1, 0, v0 - 1) < v5) {
                v3 = (v2 as u8);
                v4 = true;
            };
            v2 = v2 + 1;
        };
        v3
    }

    public fun free_of(arg0: &Spring, arg1: u8) : u64 {
        0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::cap_of(arg1) - *0x1::vector::borrow<u64>(&arg0.live, (arg1 as u64))
    }

    public fun free_total(arg0: &Spring) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::n_rarities()) {
            let v2 = v1 + 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::cap_of((v0 as u8));
            v1 = v2 - *0x1::vector::borrow<u64>(&arg0.live, v0);
            v0 = v0 + 1;
        };
        v1
    }

    entry fun fuse(arg0: &mut Spring, arg1: &0x2::random::Random, arg2: Droplet, arg3: Droplet, arg4: Droplet, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = &mut v0;
        let v2 = do_fuse(arg0, v1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<Droplet>(v2, 0x2::tx_context::sender(arg5));
    }

    public fun fused(arg0: &Spring) : u64 {
        arg0.fused
    }

    fun give_slot(arg0: &mut Spring, arg1: u8, arg2: u8, arg3: u64) {
        let v0 = (arg1 as u64);
        if (*0x1::vector::borrow<u64>(&arg0.live, v0) > 0) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.live, v0) = *0x1::vector::borrow<u64>(&arg0.live, v0) - 1;
        };
        let v1 = ((arg2 - 1) as u64);
        if (*0x1::vector::borrow<u64>(&arg0.tiers, v1) > 0) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.tiers, v1) = *0x1::vector::borrow<u64>(&arg0.tiers, v1) - 1;
        };
        let v2 = if (arg0.locked > arg3) {
            arg0.locked - arg3
        } else {
            0
        };
        arg0.locked = v2;
    }

    public fun has_trace(arg0: &Droplet) : bool {
        arg0.trace
    }

    fun inherit_trait(arg0: u8, arg1: &mut 0x2::random::RandomGenerator) : u8 {
        let v0 = 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::count_bits(arg0);
        if (v0 == 0) {
            return 0
        };
        0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::nth_set_bit(arg0, 0x2::random::generate_u8_in_range(arg1, 0, v0 - 1))
    }

    fun init(arg0: SPRING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SPRING>(arg0, arg1);
        let v1 = 0x2::display::new<Droplet>(&v0, arg1);
        0x2::display::add<Droplet>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Droplet>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"One of 2222 drops of water on Sui. It holds its own DROPLETS inside it; melt it and the token comes back."));
        0x2::display::add<Droplet>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://suidroplets.com/art/{id}.png"));
        0x2::display::add<Droplet>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"https://suidroplets.com/art/{id}.png"));
        0x2::display::add<Droplet>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suidroplets.com"));
        0x2::display::add<Droplet>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Droplets"));
        0x2::display::add<Droplet>(&mut v1, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier_name}"));
        0x2::display::add<Droplet>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity_name}"));
        0x2::display::update_version<Droplet>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Droplet>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Spring{
            id     : 0x2::object::new(arg1),
            live   : vector[0, 0, 0, 0, 0, 0],
            tiers  : vector[0, 0, 0, 0, 0, 0],
            minted : 0,
            melted : 0,
            fused  : 0,
            locked : 0,
        };
        0x2::transfer::share_object<Spring>(v2);
    }

    public fun is_marbled(arg0: &Droplet) : bool {
        arg0.marbled
    }

    public fun is_pure(arg0: &Droplet) : bool {
        arg0.pure
    }

    public fun lineage(arg0: &Droplet) : &vector<u64> {
        &arg0.lineage
    }

    public fun live_of(arg0: &Spring, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.live, (arg1 as u64))
    }

    public fun live_total(arg0: &Spring) : u64 {
        0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::drops() - free_total(arg0)
    }

    public fun locked(arg0: &Spring) : u64 {
        arg0.locked
    }

    public fun melt(arg0: &mut Spring, arg1: Droplet, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS> {
        let Droplet {
            id          : v0,
            serial      : v1,
            tier        : v2,
            rarity      : v3,
            purity      : _,
            weight      : _,
            traits      : _,
            colors      : _,
            pure        : _,
            marbled     : _,
            trace       : _,
            upgrades    : _,
            lineage     : _,
            born_epoch  : _,
            name        : _,
            tier_name   : _,
            rarity_name : _,
            held        : v17,
        } = arg1;
        let v18 = v17;
        let v19 = v0;
        let v20 = 0x2::balance::value<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&v18);
        give_slot(arg0, v3, v2, v20);
        arg0.melted = arg0.melted + 1;
        0x2::object::delete(v19);
        let v21 = Melted{
            droplet : 0x2::object::uid_to_inner(&v19),
            serial  : v1,
            tier    : v2,
            rarity  : v3,
            units   : v20,
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Melted>(v21);
        0x2::coin::from_balance<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(v18, arg2)
    }

    entry fun melt_to_sender(arg0: &mut Spring, arg1: Droplet, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = melt(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun melted(arg0: &Spring) : u64 {
        arg0.melted
    }

    fun mint_one(arg0: &mut Spring, arg1: &mut 0x2::random::RandomGenerator, arg2: 0x2::balance::Balance<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>, arg3: &mut 0x2::tx_context::TxContext) : Droplet {
        let v0 = draw_rarity(arg0, arg1);
        arg0.minted = arg0.minted + 1;
        let v1 = arg0.minted;
        take_slot(arg0, v0, 1, 0x2::balance::value<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&arg2));
        let (v2, v3, v4) = compose_name(1, v0, v1);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, v1);
        Droplet{
            id          : 0x2::object::new(arg3),
            serial      : v1,
            tier        : 1,
            rarity      : v0,
            purity      : 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::purity_of(v0),
            weight      : 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::fresh_weight(v0),
            traits      : one_random_trait(arg1),
            colors      : 1 << v0,
            pure        : false,
            marbled     : false,
            trace       : v0 == 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::prism(),
            upgrades    : 0,
            lineage     : v5,
            born_epoch  : 0x2::tx_context::epoch(arg3),
            name        : v2,
            tier_name   : v3,
            rarity_name : v4,
            held        : arg2,
        }
    }

    public fun minted(arg0: &Spring) : u64 {
        arg0.minted
    }

    public fun name(arg0: &Droplet) : 0x1::string::String {
        arg0.name
    }

    fun nearest_free(arg0: &Spring, arg1: u8) : u8 {
        if (free_of(arg0, arg1) > 0) {
            return arg1
        } else {
            let v0 = arg1;
            while (v0 > 0) {
                v0 = v0 - 1;
                if (free_of(arg0, v0) > 0) {
                    return v0
                };
            };
            while (arg1 < 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::prism()) {
                let v1 = arg1 + 1;
                arg1 = v1;
                if (free_of(arg0, v1) > 0) {
                    return v1
                };
            };
            abort 13906835308214878211
        };
    }

    fun one_random_trait(arg0: &mut 0x2::random::RandomGenerator) : u8 {
        1 << 0x2::random::generate_u8_in_range(arg0, 0, 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water::n_traits() - 1)
    }

    public fun purity(arg0: &Droplet) : u64 {
        arg0.purity
    }

    public fun rarity(arg0: &Droplet) : u8 {
        arg0.rarity
    }

    public fun serial(arg0: &Droplet) : u64 {
        arg0.serial
    }

    fun take_slot(arg0: &mut Spring, arg1: u8, arg2: u8, arg3: u64) {
        let v0 = (arg1 as u64);
        *0x1::vector::borrow_mut<u64>(&mut arg0.live, v0) = *0x1::vector::borrow<u64>(&arg0.live, v0) + 1;
        let v1 = ((arg2 - 1) as u64);
        *0x1::vector::borrow_mut<u64>(&mut arg0.tiers, v1) = *0x1::vector::borrow<u64>(&arg0.tiers, v1) + 1;
        arg0.locked = arg0.locked + arg3;
    }

    public fun tier(arg0: &Droplet) : u8 {
        arg0.tier
    }

    public fun tier_count(arg0: &Spring, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.tiers, ((arg1 - 1) as u64))
    }

    public fun traits(arg0: &Droplet) : u8 {
        arg0.traits
    }

    public fun units(arg0: &Droplet) : u64 {
        0x2::balance::value<0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets::DROPLETS>(&arg0.held)
    }

    public fun upgrades(arg0: &Droplet) : u8 {
        arg0.upgrades
    }

    public fun weight(arg0: &Droplet) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v7
}

