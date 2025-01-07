module 0x5b12ca89ae9c13cfc0d167a2e7da29e2bce5148b8350831045229c1960ffb871::referrerstorage {
    struct State has store, key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
    }

    struct ReferrerAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Referrer has key {
        id: 0x2::object::UID,
        referrer: address,
    }

    struct ReferrerSet has copy, drop {
        sender: address,
        referrer: address,
    }

    struct PublickeyChanged has copy, drop {
        sender: address,
        old_public_key: vector<u8>,
        new_public_key: vector<u8>,
    }

    struct REFERRERSTORAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REFERRERSTORAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id         : 0x2::object::new(arg1),
            public_key : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::public_share_object<State>(v0);
        let v1 = ReferrerAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<ReferrerAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun referrer(arg0: &Referrer) : address {
        arg0.referrer
    }

    public entry fun set_public_key(arg0: &mut State, arg1: vector<u8>, arg2: &ReferrerAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.public_key = arg1;
        let v0 = PublickeyChanged{
            sender         : 0x2::tx_context::sender(arg3),
            old_public_key : arg0.public_key,
            new_public_key : arg1,
        };
        0x2::event::emit<PublickeyChanged>(v0);
    }

    public entry fun set_referrer(arg0: address, arg1: vector<u8>, arg2: &State, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0 != @0x0, 0);
        assert!(arg0 != v0, 1);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg0));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg2.public_key, &v1), 2);
        let v2 = Referrer{
            id       : 0x2::object::new(arg3),
            referrer : arg0,
        };
        0x2::transfer::transfer<Referrer>(v2, v0);
        let v3 = ReferrerSet{
            sender   : v0,
            referrer : arg0,
        };
        0x2::event::emit<ReferrerSet>(v3);
    }

    // decompiled from Move bytecode v6
}

