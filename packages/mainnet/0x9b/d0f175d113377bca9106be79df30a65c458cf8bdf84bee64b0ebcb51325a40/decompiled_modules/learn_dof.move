module 0x9bd0f175d113377bca9106be79df30a65c458cf8bdf84bee64b0ebcb51325a40::learn_dof {
    struct MinterData has store, key {
        id: 0x2::object::UID,
        swords: vector<Sword>,
    }

    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        type: 0x1::string::String,
        level: u64,
    }

    struct Sword has copy, store {
        name: 0x1::string::String,
        type: 0x1::string::String,
    }

    public entry fun burn(arg0: Hero, arg1: &mut 0x2::tx_context::TxContext) {
        let Hero {
            id    : v0,
            name  : _,
            type  : _,
            level : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Sword{
            name : 0x1::string::utf8(b"Sword One"),
            type : 0x1::string::utf8(b"One"),
        };
        let v1 = Sword{
            name : 0x1::string::utf8(b"Sword Two"),
            type : 0x1::string::utf8(b"Two"),
        };
        let v2 = 0x1::vector::empty<Sword>();
        let v3 = &mut v2;
        0x1::vector::push_back<Sword>(v3, v0);
        0x1::vector::push_back<Sword>(v3, v1);
        let v4 = MinterData{
            id     : 0x2::object::new(arg0),
            swords : v2,
        };
        0x2::transfer::share_object<MinterData>(v4);
    }

    public entry fun mint_hero(arg0: &mut MinterData, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{
            id    : 0x2::object::new(arg5),
            name  : arg1,
            type  : arg2,
            level : arg3,
        };
        0x2::dynamic_field::add<vector<u8>, Sword>(&mut v0.id, b"sword", *0x1::vector::borrow_mut<Sword>(&mut arg0.swords, arg4));
        0x2::transfer::public_transfer<Hero>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun transfer_hero(arg0: Hero, arg1: address) {
        0x2::transfer::public_transfer<Hero>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

