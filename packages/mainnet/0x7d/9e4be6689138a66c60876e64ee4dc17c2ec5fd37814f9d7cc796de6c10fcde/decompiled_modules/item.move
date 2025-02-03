module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item {
    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        item_category: 0x1::string::String,
        item_set: 0x1::string::String,
        item_type: 0x1::string::String,
        level: u8,
        amount: u32,
        stackable: bool,
    }

    struct ITEM has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u32, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : Item {
        if (arg5 > 1) {
            assert!(arg6, 103);
        };
        Item{
            id            : 0x2::object::new(arg7),
            name          : arg0,
            item_category : arg1,
            item_set      : arg2,
            item_type     : arg3,
            level         : arg4,
            amount        : arg5,
            stackable     : arg6,
        }
    }

    public(friend) fun add_field<T0: copy + drop + store, T1: store>(arg0: &mut Item, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun amount(arg0: &Item) : u32 {
        arg0.amount
    }

    public(friend) fun assert_item_type(arg0: &Item, arg1: vector<u8>) {
        assert!(arg0.item_type == 0x1::string::utf8(arg1), 101);
    }

    public(friend) fun borrow_field<T0: copy + drop + store, T1: store>(arg0: &Item, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_field_mut<T0: copy + drop + store, T1: store>(arg0: &mut Item, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun destroy(arg0: Item) {
        let Item {
            id            : v0,
            name          : _,
            item_category : _,
            item_set      : _,
            item_type     : _,
            level         : _,
            amount        : _,
            stackable     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun has_field<T0: copy + drop + store>(arg0: &Item, arg1: T0) : bool {
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    fun init(arg0: ITEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.aresrpg.world"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.aresrpg.world/item/{item_type}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Item part of the AresRPG universe."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aresrpg.world"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AresRPG"));
        let v4 = 0x2::package::claim<ITEM>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Item>(&v4, v0, v2, arg1);
        0x2::display::update_version<Item>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun item_type(arg0: &Item) : 0x1::string::String {
        arg0.item_type
    }

    public(friend) fun merge(arg0: &mut Item, arg1: Item) {
        assert!(arg0.stackable, 103);
        assert!(arg0.item_type == arg1.item_type, 101);
        arg0.amount = arg0.amount + arg1.amount;
        destroy(arg1);
    }

    public(friend) fun split(arg0: &mut Item, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : Item {
        assert!(arg0.stackable, 103);
        let v0 = new(arg0.name, arg0.item_category, arg0.item_set, arg0.item_type, arg0.level, arg1, true, arg2);
        arg0.amount = arg0.amount - arg1;
        assert!(arg0.amount >= 1, 102);
        assert!(v0.amount >= 1, 102);
        v0
    }

    public fun stackable(arg0: &Item) : bool {
        arg0.stackable
    }

    // decompiled from Move bytecode v6
}

