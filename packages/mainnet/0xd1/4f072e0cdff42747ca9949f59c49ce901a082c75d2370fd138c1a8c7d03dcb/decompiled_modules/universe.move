module 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe {
    struct UNIVERSE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        kind: 0x1::string::String,
        design: 0x1::string::String,
        colourway: 0x1::string::String,
        rarity: 0x1::string::String,
        edition: 0x1::string::String,
        description: 0x1::string::String,
        key: 0x1::string::String,
        serial: u64,
        total: u64,
        wear: u64,
        kills: u64,
        name_tag: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ItemMinted has copy, drop {
        item: 0x2::object::ID,
        owner: address,
        kind: 0x1::string::String,
        design: 0x1::string::String,
        colourway: 0x1::string::String,
        serial: u64,
        total: u64,
    }

    struct ItemReissued has copy, drop {
        item: 0x2::object::ID,
        kind: 0x1::string::String,
        design: 0x1::string::String,
        colourway: 0x1::string::String,
        serial: u64,
        total: u64,
    }

    struct NameTagChanged has copy, drop {
        item: 0x2::object::ID,
        name_tag: 0x1::string::String,
    }

    struct ItemBurned has copy, drop {
        item: 0x2::object::ID,
    }

    struct ItemRenamed has copy, drop {
        item: 0x2::object::ID,
        name: 0x1::string::String,
        design: 0x1::string::String,
    }

    struct ReissueCap has store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Kind"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Design"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Colourway"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Edition"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, arg3);
        0x1::vector::push_back<0x1::string::String>(v3, arg4);
        0x1::vector::push_back<0x1::string::String>(v3, arg5);
        Item{
            id          : 0x2::object::new(arg11),
            name        : arg0,
            kind        : arg1,
            design      : arg2,
            colourway   : arg3,
            rarity      : arg4,
            edition     : arg5,
            description : arg6,
            key         : arg7,
            serial      : arg8,
            total       : arg9,
            wear        : arg10,
            kills       : 0,
            name_tag    : 0x1::string::utf8(b""),
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v0, v2),
        }
    }

    public fun attributes(arg0: &Item) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun burn(arg0: Item) {
        let Item {
            id          : v0,
            name        : _,
            kind        : _,
            design      : _,
            colourway   : _,
            rarity      : _,
            edition     : _,
            description : _,
            key         : _,
            serial      : _,
            total       : _,
            wear        : _,
            kills       : _,
            name_tag    : _,
            attributes  : _,
        } = arg0;
        let v15 = v0;
        let v16 = ItemBurned{item: 0x2::object::uid_to_inner(&v15)};
        0x2::event::emit<ItemBurned>(v16);
        0x2::object::delete(v15);
    }

    public fun clear_name_tag(arg0: &mut Item) {
        set_name_tag(arg0, 0x1::string::utf8(b""));
    }

    public fun colourway(arg0: &Item) : &0x1::string::String {
        &arg0.colourway
    }

    public(friend) fun deliver(arg0: Item, arg1: address) {
        let v0 = ItemMinted{
            item      : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg1,
            kind      : arg0.kind,
            design    : arg0.design,
            colourway : arg0.colourway,
            serial    : arg0.serial,
            total     : arg0.total,
        };
        0x2::event::emit<ItemMinted>(v0);
        0x2::transfer::public_transfer<Item>(arg0, arg1);
    }

    public fun description(arg0: &Item) : &0x1::string::String {
        &arg0.description
    }

    public fun design(arg0: &Item) : &0x1::string::String {
        &arg0.design
    }

    public fun destroy_reissue_cap(arg0: ReissueCap) {
        let ReissueCap {  } = arg0;
    }

    public fun edition(arg0: &Item) : &0x1::string::String {
        &arg0.edition
    }

    public(friend) fun full_name(arg0: &Item, arg1: 0x1::string::String) : 0x1::string::String {
        numbered_name(arg1, arg0.serial, arg0.total)
    }

    fun init(arg0: UNIVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<UNIVERSE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun key(arg0: &Item) : &0x1::string::String {
        &arg0.key
    }

    public fun kills(arg0: &Item) : u64 {
        arg0.kills
    }

    public fun kind(arg0: &Item) : &0x1::string::String {
        &arg0.kind
    }

    public(friend) fun max_wear() : u64 {
        999999
    }

    public fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: u64, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        deliver(new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13), arg12);
    }

    public fun name(arg0: &Item) : &0x1::string::String {
        &arg0.name
    }

    public fun name_tag(arg0: &Item) : &0x1::string::String {
        &arg0.name_tag
    }

    public fun new_reissue_cap(arg0: &AdminCap) : ReissueCap {
        ReissueCap{dummy_field: false}
    }

    public(friend) fun numbered_name(arg0: 0x1::string::String, arg1: u64, arg2: u64) : 0x1::string::String {
        if (arg1 == 0) {
            return arg0
        };
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, arg0);
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::u64::to_string(arg1));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::u64::to_string(arg2));
        0xd3977293c984ff2f916870aa53aed338d4b2aab2952e98be70c62bc3a886173a::format::format(0x1::string::utf8(b"{} #{}/{}"), v0)
    }

    public fun rarity(arg0: &Item) : &0x1::string::String {
        &arg0.rarity
    }

    public fun reissue(arg0: &ReissueCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: u64, arg12: 0x1::string::String, arg13: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x1::u64::min(arg11, 999999), arg13);
        v0.name_tag = arg12;
        let v1 = ItemReissued{
            item      : 0x2::object::uid_to_inner(&v0.id),
            kind      : v0.kind,
            design    : v0.design,
            colourway : v0.colourway,
            serial    : v0.serial,
            total     : v0.total,
        };
        0x2::event::emit<ItemReissued>(v1);
        v0
    }

    public(friend) fun roll_wear(arg0: &mut 0x2::random::RandomGenerator) : u64 {
        0x2::random::generate_u64_in_range(arg0, 0, 999999)
    }

    public fun serial(arg0: &Item) : u64 {
        arg0.serial
    }

    public(friend) fun set_name_and_design(arg0: &mut Item, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        arg0.name = arg1;
        arg0.design = arg2;
        let v0 = 0x1::string::utf8(b"Design");
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0) = arg2;
        let v1 = ItemRenamed{
            item   : 0x2::object::uid_to_inner(&arg0.id),
            name   : arg1,
            design : arg2,
        };
        0x2::event::emit<ItemRenamed>(v1);
    }

    public fun set_name_tag(arg0: &mut Item, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 32, 13906835149301088259);
        let v0 = 0x1::string::as_bytes(&arg1);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = 0x1::vector::borrow<u8>(v0, v1);
            let v4 = *v3 >= 32 && *v3 <= 126;
            if (!v4) {
                v2 = false;
                /* label 13 */
                assert!(v2, 13906835153596186629);
                arg0.name_tag = arg1;
                let v5 = NameTagChanged{
                    item     : 0x2::object::uid_to_inner(&arg0.id),
                    name_tag : arg1,
                };
                0x2::event::emit<NameTagChanged>(v5);
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 13 */
    }

    public fun setup_display(arg0: &AdminCap, arg1: &mut 0x2::display_registry::DisplayRegistry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 13906835604567883783);
        let (v0, v1) = 0x2::display_registry::new<Item>(arg1, 0x1::internal::permit<Item>(), arg4);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 13906835617452392447);
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            0x2::display_registry::set<Item>(&mut v3, &v2, 0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x1::vector::pop_back<0x1::string::String>(&mut arg3));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg2);
        0x1::vector::destroy_empty<0x1::string::String>(arg3);
        0x2::display_registry::share<Item>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Item>>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun total(arg0: &Item) : u64 {
        arg0.total
    }

    public fun wear(arg0: &Item) : u64 {
        arg0.wear
    }

    // decompiled from Move bytecode v7
}

