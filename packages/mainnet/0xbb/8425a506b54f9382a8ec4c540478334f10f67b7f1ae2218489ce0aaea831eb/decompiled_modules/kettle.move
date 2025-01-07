module 0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        kettle_id: 0x2::object::ID,
    }

    struct Kettle has store, key {
        id: 0x2::object::UID,
        bag: 0x2::object_bag::ObjectBag,
        most_recent_boil_time: u64,
        meta: vector<u8>,
    }

    struct MintEvent has copy, drop {
        kettle_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct BoilEvent has copy, drop {
        kettle_id: 0x2::object::ID,
        amount: u64,
        method: vector<u8>,
    }

    struct MethodEvent has copy, drop {
        kettle_id: 0x2::object::ID,
        method: vector<u8>,
        data: vector<u8>,
    }

    public entry fun attach_fountain_proof<T0, T1>(arg0: &AdminCap, arg1: &mut Kettle, arg2: 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin_cap(arg0, arg1);
        let v0 = MethodEvent{
            kettle_id : 0x2::object::id<Kettle>(arg1),
            method    : b"fountain",
            data      : 0x2::object::id_bytes<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>>(&arg2),
        };
        0x2::event::emit<MethodEvent>(v0);
        0x2::object_bag::add<vector<u8>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>>(&mut arg1.bag, b"fountain_proof", arg2);
    }

    public fun boil_with_fountain<T0, T1>(arg0: &mut Kettle, arg1: &0x2::clock::Clock, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<T0, T1>) : 0x2::balance::Balance<T1> {
        let v0 = b"fountain_proof";
        if (0x2::object_bag::contains<vector<u8>>(&arg0.bag, v0)) {
            let v1 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::claim<T0, T1>(arg1, arg2, 0x2::object_bag::borrow_mut<vector<u8>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>>(&mut arg0.bag, v0));
            arg0.most_recent_boil_time = 0x2::clock::timestamp_ms(arg1);
            let v2 = BoilEvent{
                kettle_id : 0x2::object::id<Kettle>(arg0),
                amount    : 0x2::balance::value<T1>(&v1),
                method    : b"fountain",
            };
            0x2::event::emit<BoilEvent>(v2);
            return v1
        };
        0x2::balance::zero<T1>()
    }

    fun check_admin_cap(arg0: &AdminCap, arg1: &Kettle) {
        assert!(arg0.kettle_id == 0x2::object::id<Kettle>(arg1), 2);
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint_no_entry(arg0);
        0x2::transfer::public_transfer<Kettle>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_no_entry(arg0: &mut 0x2::tx_context::TxContext) : (Kettle, AdminCap) {
        let v0 = Kettle{
            id                    : 0x2::object::new(arg0),
            bag                   : 0x2::object_bag::new(arg0),
            most_recent_boil_time : 0,
            meta                  : 0x1::vector::empty<u8>(),
        };
        let v1 = 0x2::object::id<Kettle>(&v0);
        let v2 = AdminCap{
            id        : 0x2::object::new(arg0),
            kettle_id : v1,
        };
        let v3 = MintEvent{
            kettle_id    : v1,
            admin_cap_id : 0x2::object::id<AdminCap>(&v2),
        };
        0x2::event::emit<MintEvent>(v3);
        (v0, v2)
    }

    public entry fun release_fountain_proof<T0, T1>(arg0: &AdminCap, arg1: &mut Kettle, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin_cap(arg0, arg1);
        let v0 = MethodEvent{
            kettle_id : 0x2::object::id<Kettle>(arg1),
            method    : b"fountain",
            data      : b"",
        };
        0x2::event::emit<MethodEvent>(v0);
        0x2::transfer::public_transfer<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>>(0x2::object_bag::remove<vector<u8>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>>(&mut arg1.bag, b"fountain_proof"), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

