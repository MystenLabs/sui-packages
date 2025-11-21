module 0x390351dbd24979791bc5c61ab0ca8afddff0c2b2dc8d048fd93f244e168e041c::keek {
    struct KEEK has drop {
        dummy_field: bool,
    }

    struct M has drop, store {
        amount: u64,
        to: address,
        until: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KEEEK has store, key {
        id: 0x2::object::UID,
        s: vector<u8>,
        u: 0x2::table::Table<vector<u8>, bool>,
        b: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
    }

    public fun a(arg0: &mut KEEEK, arg1: &AdminCap, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 33, 4);
        arg0.s = arg2;
    }

    public fun execute(arg0: &mut KEEEK, arg1: 0x1::option::Option<0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = false;
        if (0x1::option::is_some<0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>>(&arg1)) {
            0x2::balance::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.b, 0x2::coin::into_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x1::option::extract<0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>>(&mut arg1)));
            v0 = true;
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>>(arg1);
        if (0x1::vector::length<u8>(&arg2) > 0) {
            assert!(0x1::vector::length<u8>(&arg0.s) == 33, 6);
            let v1 = 0x2::bcs::new(arg2);
            let v2 = M{
                amount : 0x2::bcs::peel_u64(&mut v1),
                to     : 0x2::bcs::peel_address(&mut v1),
                until  : 0x2::bcs::peel_u64(&mut v1),
            };
            assert!(v2.amount > 0, 3);
            assert!(0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg0.b) >= v2.amount, 2);
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.u, arg2), 0);
            v(&arg2, &arg0.s, &arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>>(0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.b, v2.amount), arg4), v2.to);
            0x2::table::add<vector<u8>, bool>(&mut arg0.u, arg2, true);
            v0 = true;
        };
        assert!(v0, 1);
    }

    fun init(arg0: KEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = KEEEK{
            id : 0x2::object::new(arg1),
            s  : b"",
            u  : 0x2::table::new<vector<u8>, bool>(arg1),
            b  : 0x2::balance::zero<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(),
        };
        0x2::transfer::public_share_object<KEEEK>(v1);
    }

    fun v(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 33, 4);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 1;
        loop {
            if (v1 == 33) {
                break
            };
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v1));
            v1 = v1 + 1;
        };
        assert!(0x2::ed25519::ed25519_verify(arg2, &v0, arg0), 5);
    }

    // decompiled from Move bytecode v6
}

