module 0xd67366f03dbfe7f00e0da76be69fd910d50ba83a25e837b16bc3ce8639dcc063::lootbox {
    struct Lootbox has store, key {
        id: 0x2::object::UID,
        drops: vector<Drop>,
        url: 0x2::url::Url,
    }

    struct Drop has store, key {
        id: 0x2::object::UID,
        color: 0x1::option::Option<u64>,
        url: 0x2::url::Url,
    }

    struct DropAdded has copy, drop {
        lootbox_id: 0x2::object::ID,
        drop_id: 0x2::object::ID,
    }

    public entry fun add_drop_lootbox(arg0: &mut Lootbox, arg1: Drop) {
        let v0 = DropAdded{
            lootbox_id : 0x2::object::id<Lootbox>(arg0),
            drop_id    : 0x2::object::id<Drop>(&arg1),
        };
        0x2::event::emit<DropAdded>(v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Drop>(&mut arg0.id, 0x2::object::id<Drop>(&arg1), arg1);
    }

    public entry fun create_drop(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Drop{
            id    : 0x2::object::new(arg1),
            color : 0x1::option::none<u64>(),
            url   : 0x2::url::new_unsafe_from_bytes(arg0),
        };
        0x2::transfer::transfer<Drop>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Lootbox{
            id    : 0x2::object::new(arg1),
            drops : 0x1::vector::empty<Drop>(),
            url   : 0x2::url::new_unsafe_from_bytes(arg0),
        };
        let v1 = Drop{
            id    : 0x2::object::new(arg1),
            color : 0x1::option::none<u64>(),
            url   : 0x2::url::new_unsafe_from_bytes(arg0),
        };
        let v2 = Drop{
            id    : 0x2::object::new(arg1),
            color : 0x1::option::none<u64>(),
            url   : 0x2::url::new_unsafe_from_bytes(arg0),
        };
        let v3 = Drop{
            id    : 0x2::object::new(arg1),
            color : 0x1::option::none<u64>(),
            url   : 0x2::url::new_unsafe_from_bytes(arg0),
        };
        let v4 = Drop{
            id    : 0x2::object::new(arg1),
            color : 0x1::option::none<u64>(),
            url   : 0x2::url::new_unsafe_from_bytes(arg0),
        };
        0x1::vector::push_back<Drop>(&mut v0.drops, v1);
        0x1::vector::push_back<Drop>(&mut v0.drops, v2);
        0x1::vector::push_back<Drop>(&mut v0.drops, v3);
        0x1::vector::push_back<Drop>(&mut v0.drops, v4);
        0x2::transfer::public_transfer<Lootbox>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

