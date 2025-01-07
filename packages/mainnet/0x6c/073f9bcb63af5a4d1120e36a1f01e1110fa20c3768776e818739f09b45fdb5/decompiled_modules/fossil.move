module 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::fossil {
    struct FOSSIL has drop {
        dummy_field: bool,
    }

    struct Fossil has key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct BurnCap has store, key {
        id: 0x2::object::UID,
    }

    struct Mint has copy, drop {
        token_id: 0x2::object::ID,
        sender: address,
    }

    struct Burn has copy, drop {
        token_id: 0x2::object::ID,
        sender: address,
    }

    public entry fun burn(arg0: &BurnCap, arg1: &mut 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::Supply, arg2: Fossil, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Burn{
            token_id : 0x2::object::id<Fossil>(&arg2),
            sender   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Burn>(v0);
        0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::decrement(arg1, 1);
        let Fossil { id: v1 } = arg2;
        0x2::object::delete(v1);
    }

    fun init(arg0: FOSSIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FOSSIL>(arg0, arg1);
        let v1 = 0x2::display::new<Fossil>(&v0, arg1);
        0x2::display::add<Fossil>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sacabam Fossil"));
        0x2::display::add<Fossil>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://bafybeiaaorv7mclexpn4pnhdgey3qp5luya4g7ucq3k7m7d4joxo6cewma"));
        0x2::display::add<Fossil>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"After being stuck in a fossil for a mind-blowing 470 million years, the time has finally come for me to wake up and make my presence known, babe."));
        0x2::display::update_version<Fossil>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Fossil>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = BurnCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<BurnCap>(v2);
        0x2::transfer::public_share_object<0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::Supply>(0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::new(3500, arg1));
    }

    public fun mint(arg0: &MintCap, arg1: &mut 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::Supply, arg2: &mut 0x2::tx_context::TxContext) : Fossil {
        let v0 = Fossil{id: 0x2::object::new(arg2)};
        0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::increment(arg1, 1);
        let v1 = Mint{
            token_id : 0x2::object::id<Fossil>(&v0),
            sender   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Mint>(v1);
        v0
    }

    public entry fun mint_and_transfer(arg0: &MintCap, arg1: &mut 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::Supply, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2);
        0x2::transfer::transfer<Fossil>(v0, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun new_mint_cap(arg0: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

