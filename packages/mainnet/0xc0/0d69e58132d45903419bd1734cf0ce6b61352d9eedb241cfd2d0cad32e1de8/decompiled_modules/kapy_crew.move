module 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew {
    struct KAPY_CREW has drop {
        dummy_field: bool,
    }

    struct KapyCrew has store, key {
        id: 0x2::object::UID,
        index: u32,
        name: 0x1::string::String,
        members: 0x2::vec_set::VecSet<u8>,
        strength: u16,
        found_treasure: bool,
    }

    public fun build_crew(arg0: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : KapyCrew {
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) < 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::ship_price()) {
            err_not_enough_fund_to_build_crew();
        };
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::add_treasure(arg0, arg1);
        build_crew_internal(arg0, arg2, arg3)
    }

    public fun build_crew_by_god(arg0: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg1: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::GodPower, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : KapyCrew {
        build_crew_internal(arg0, arg2, arg3)
    }

    entry fun build_crew_by_god_to(arg0: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg1: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::GodPower, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<KapyCrew>(build_crew_internal(arg0, arg2, arg4), arg3);
    }

    fun build_crew_internal(arg0: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : KapyCrew {
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::add_crew(arg0);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::crew_supply(arg0);
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::events::emit_new_crew(0x2::object::uid_to_inner(&v0), v1);
        KapyCrew{
            id             : v0,
            index          : v1,
            name           : arg1,
            members        : 0x2::vec_set::empty<u8>(),
            strength       : 0,
            found_treasure : false,
        }
    }

    fun err_already_found_treasure() {
        abort 2
    }

    fun err_not_enough_fund_to_build_crew() {
        abort 1
    }

    fun err_recruit_same_kind_of_pirate() {
        abort 0
    }

    fun err_too_weak_to_find_treasure() {
        abort 3
    }

    public fun found_treasure(arg0: &KapyCrew) : bool {
        arg0.found_treasure
    }

    fun get_strength(arg0: 0x2::vec_set::VecSet<u8>) : u16 {
        let v0 = 0;
        let v1 = 0x2::vec_set::into_keys<u8>(arg0);
        0x1::vector::reverse<u8>(&mut v1);
        while (0x1::vector::length<u8>(&v1) != 0) {
            let v2 = (v0 as u16);
            v0 = v2 + (0x1::u64::pow(2, 0x1::vector::pop_back<u8>(&mut v1)) as u16);
        };
        0x1::vector::destroy_empty<u8>(v1);
        v0
    }

    public fun get_treasure(arg0: &mut KapyCrew, arg1: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (found_treasure(arg0)) {
            err_already_found_treasure();
        };
        if (strength(arg0) < 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::strength_threshold(arg1)) {
            err_too_weak_to_find_treasure();
        };
        arg0.found_treasure = true;
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::events::emit_found_treasure(0x2::object::id<KapyCrew>(arg0), index(arg0), strength(arg0));
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::take_treasure(arg1, arg2)
    }

    public fun index(arg0: &KapyCrew) : u32 {
        arg0.index
    }

    fun init(arg0: KAPY_CREW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Kapy Crew: {name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Complete exercises to recruit pirates and go find treasure!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmYmdsih37DJe8RRcWGhEe2WUGN6Vmog5ezyndMBGgqotE/KapyCrew_{strength}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://lu.ma/eajq2r68"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket X Typus"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<KAPY_CREW>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<KapyCrew>(&v5, v0, v2, arg1);
        0x2::display::update_version<KapyCrew>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<KapyCrew>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
    }

    public fun members(arg0: &KapyCrew) : &0x2::vec_set::VecSet<u8> {
        &arg0.members
    }

    public fun name(arg0: &KapyCrew) : 0x1::string::String {
        arg0.name
    }

    public fun recruit(arg0: &mut KapyCrew, arg1: 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_pirate::KapyPirate) {
        let v0 = 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_pirate::get_recruited(arg1);
        if (0x2::vec_set::contains<u8>(members(arg0), &v0)) {
            err_recruit_same_kind_of_pirate();
        };
        0x2::vec_set::insert<u8>(&mut arg0.members, v0);
        arg0.strength = get_strength(arg0.members);
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::events::emit_recruit(0x2::object::id<KapyCrew>(arg0), index(arg0), strength(arg0), v0);
    }

    public fun strength(arg0: &KapyCrew) : u16 {
        arg0.strength
    }

    public fun update_name(arg0: &mut KapyCrew, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

