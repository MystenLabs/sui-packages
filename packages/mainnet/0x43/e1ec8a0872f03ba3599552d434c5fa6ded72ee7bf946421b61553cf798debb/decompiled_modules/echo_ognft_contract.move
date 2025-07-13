module 0x43e1ec8a0872f03ba3599552d434c5fa6ded72ee7bf946421b61553cf798debb::echo_ognft_contract {
    struct OgNft has store, key {
        id: 0x2::object::UID,
        owner: address,
        number: u8,
    }

    struct OgRegistry has store, key {
        id: 0x2::object::UID,
        ogs: 0x2::table::Table<address, u8>,
        free_mints: 0x2::table::Table<address, u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        founder: address,
    }

    struct FreeMintClaimedEvent has copy, drop {
        owner: address,
        count: u8,
    }

    public entry fun claim_free_mint(arg0: &mut OgRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (0x2::table::contains<address, u8>(&arg0.ogs, v0)) {
            *0x2::table::borrow<address, u8>(&arg0.ogs, v0)
        } else {
            0
        };
        assert!(v1 > 0, 200);
        let v2 = 0x2::table::borrow_mut<address, u8>(&mut arg0.free_mints, v0);
        assert!(*v2 > 0, 201);
        *v2 = *v2 - 1;
        let v3 = FreeMintClaimedEvent{
            owner : v0,
            count : *v2,
        };
        0x2::event::emit<FreeMintClaimedEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg0),
            founder : 0x2::tx_context::sender(arg0),
        };
        let v1 = OgRegistry{
            id         : 0x2::object::new(arg0),
            ogs        : 0x2::table::new<address, u8>(arg0),
            free_mints : 0x2::table::new<address, u8>(arg0),
        };
        0x2::transfer::share_object<AdminCap>(v0);
        0x2::transfer::share_object<OgRegistry>(v1);
    }

    public entry fun set_og_holder(arg0: &AdminCap, arg1: &mut OgRegistry, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.founder, 100);
        assert!(arg3 <= 5, 101);
        0x2::table::add<address, u8>(&mut arg1.ogs, arg2, arg3);
        0x2::table::add<address, u8>(&mut arg1.free_mints, arg2, 5);
    }

    // decompiled from Move bytecode v6
}

