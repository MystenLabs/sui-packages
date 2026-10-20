module 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item {
    struct ITEM has drop {
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

    struct NameTagChanged has copy, drop {
        item: 0x2::object::ID,
        name_tag: 0x1::string::String,
    }

    struct ItemBurned has copy, drop {
        item: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : Item {
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
        }
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
        } = arg0;
        let v14 = v0;
        let v15 = ItemBurned{item: 0x2::object::uid_to_inner(&v14)};
        0x2::event::emit<ItemBurned>(v15);
        0x2::object::delete(v14);
    }

    public fun clear_name_tag(arg0: &mut Item) {
        set_name_tag(arg0, 0x1::string::utf8(b""));
    }

    public fun colourway(arg0: &Item) : &0x1::string::String {
        &arg0.colourway
    }

    public(friend) fun deliver(arg0: Item, arg1: address) {
        let v0 = ItemMinted{
            item      : 0x2::object::id<Item>(&arg0),
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

    public fun edition(arg0: &Item) : &0x1::string::String {
        &arg0.edition
    }

    fun init(arg0: ITEM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ITEM>(arg0, arg1), 0x2::tx_context::sender(arg1));
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

    public fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: u64, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        deliver(new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13), arg12);
    }

    public fun name(arg0: &Item) : &0x1::string::String {
        &arg0.name
    }

    public fun name_tag(arg0: &Item) : &0x1::string::String {
        &arg0.name_tag
    }

    public fun rarity(arg0: &Item) : &0x1::string::String {
        &arg0.rarity
    }

    public fun serial(arg0: &Item) : u64 {
        arg0.serial
    }

    public fun set_name_tag(arg0: &mut Item, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 32, 13906834874423115778);
        let v0 = 0x1::string::as_bytes(&arg1);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = 0x1::vector::borrow<u8>(v0, v1);
            let v4 = *v3 >= 32 && *v3 <= 126;
            if (!v4) {
                v2 = false;
                /* label 12 */
                assert!(v2, 13906834878718214148);
                arg0.name_tag = arg1;
                let v5 = NameTagChanged{
                    item     : 0x2::object::id<Item>(arg0),
                    name_tag : arg1,
                };
                0x2::event::emit<NameTagChanged>(v5);
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 12 */
    }

    public fun setup_display(arg0: &AdminCap, arg1: &mut 0x2::display_registry::DisplayRegistry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 13906835003272396806);
        let (v0, v1) = 0x2::display_registry::new<Item>(arg1, 0x1::internal::permit<Item>(), arg4);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 13906835016156971007);
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

