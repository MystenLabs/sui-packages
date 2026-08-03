module 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce {
    struct H032e6 has store, key {
        id: 0x2::object::UID,
        hc3725: 0x2::object::ID,
        h332f0: 0x2::object::ID,
        h8f311: vector<0x1::option::Option<u128>>,
        hd05a7: vector<0x1::option::Option<u128>>,
        hd00a6: u64,
        hca48a: u64,
        hed78c: u64,
        hdaef6: u64,
        hbcb8a: u64,
        h100f5: u64,
    }

    public(friend) fun h14ff8(arg0: &mut H032e6) : vector<u128> {
        let v0 = vector[];
        let v1 = &mut arg0.h8f311;
        let v2 = &mut v0;
        h8fd0c(v1, v2);
        let v3 = &mut arg0.hd05a7;
        let v4 = &mut v0;
        h8fd0c(v3, v4);
        v0
    }

    public(friend) fun h1a68c(arg0: &mut H032e6) : &mut vector<0x1::option::Option<u128>> {
        &mut arg0.h8f311
    }

    public(friend) fun h1bb22(arg0: &mut H032e6) : &mut vector<0x1::option::Option<u128>> {
        &mut arg0.hd05a7
    }

    public(friend) fun h21ed2(arg0: &vector<0x1::option::Option<u128>>) {
        assert!(0x1::vector::length<0x1::option::Option<u128>>(arg0) > 0, 514);
    }

    public(friend) fun h295f4<T0>(arg0: &H032e6, arg1: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg2: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>) {
        assert!(arg0.hc3725 == 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>>(arg1), 511);
        assert!(arg0.h332f0 == 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>>(arg2), 512);
        h21ed2(&arg0.h8f311);
        h21ed2(&arg0.hd05a7);
    }

    public fun h47cc1<T0>(arg0: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg1: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg2: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg3: vector<u128>, arg4: vector<u128>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : address {
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0) == 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>>(arg1), 511);
        assert!(arg5 > 0, 532);
        assert!(arg6 > 0, 534);
        h68d09(arg8, arg9, arg10);
        let v0 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::account_id<T0>(arg1);
        let v1 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::orderbook<T0>(arg2);
        let v2 = H032e6{
            id     : 0x2::object::new(arg12),
            hc3725 : 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>>(arg1),
            h332f0 : 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>>(arg2),
            h8f311 : h556ee(arg5),
            hd05a7 : h556ee(arg5),
            hd00a6 : arg6,
            hca48a : arg7,
            hed78c : arg8,
            hdaef6 : arg9,
            hbcb8a : arg10,
            h100f5 : arg11,
        };
        let v3 = &mut v2.h8f311;
        h6c965(v1, v0, v3, &arg3, true);
        let v4 = &mut v2.hd05a7;
        h6c965(v1, v0, v4, &arg4, false);
        0x2::transfer::share_object<H032e6>(v2);
        0x2::object::uid_to_address(&v2.id)
    }

    public fun h552f1(arg0: &H032e6) : (u64, u64, u64, u64, u64) {
        (arg0.hca48a, arg0.hed78c, arg0.hdaef6, arg0.hbcb8a, arg0.h100f5)
    }

    fun h556ee(arg0: u64) : vector<0x1::option::Option<u128>> {
        let v0 = 0x1::vector::empty<0x1::option::Option<u128>>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<0x1::option::Option<u128>>(&mut v0, 0x1::option::none<u128>());
            v1 = v1 + 1;
        };
        v0
    }

    fun h5aa72(arg0: &vector<0x1::option::Option<u128>>, arg1: u128) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<u128>>(arg0)) {
            if (0x1::option::contains<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(arg0, v0), &arg1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun h644d5(arg0: &mut H032e6, arg1: bool, arg2: u128) {
        if (arg1) {
            let v0 = &mut arg0.h8f311;
            h88a9c(v0, arg2);
        } else {
            let v1 = &mut arg0.hd05a7;
            h88a9c(v1, arg2);
        };
    }

    fun h68d09(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg1 <= arg0 && arg0 <= arg2, 524);
    }

    fun h6c965(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::Orderbook, arg1: u64, arg2: &mut vector<0x1::option::Option<u128>>, arg3: &vector<u128>, arg4: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg3)) {
            let v1 = *0x1::vector::borrow<u128>(arg3, v0);
            v0 = v0 + 1;
            assert!(0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::he7a1a(v1) != arg4, 522);
            if (h5aa72(arg2, v1)) {
                continue
            };
            let v2 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::get_order(arg0, v1);
            if (0x1::option::is_none<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::Order>(&v2)) {
                continue
            };
            let v3 = 0x1::option::extract<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::Order>(&mut v2);
            let (v4, _, _, _, _, _) = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::as_parts(&v3);
            assert!(v4 == arg1, 523);
            h88a9c(arg2, v1);
        };
    }

    public fun h6f66c(arg0: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg1: &mut H032e6, arg2: u64) {
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0) == arg1.hc3725, 511);
        assert!(arg2 > 0, 534);
        arg1.hd00a6 = arg2;
    }

    public fun h727b4(arg0: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg1: &mut H032e6, arg2: u64) {
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0) == arg1.hc3725, 511);
        assert!(arg2 > 0, 532);
        let v0 = &mut arg1.h8f311;
        hcee99(v0, arg2);
        let v1 = &mut arg1.hd05a7;
        hcee99(v1, arg2);
    }

    public(friend) fun h88a9c(arg0: &mut vector<0x1::option::Option<u128>>, arg1: u128) {
        h21ed2(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<u128>>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<0x1::option::Option<u128>>(arg0, v0);
            if (0x1::option::is_none<u128>(v1)) {
                0x1::option::fill<u128>(v1, arg1);
                return
            };
            v0 = v0 + 1;
        };
        abort 513
    }

    fun h8fd0c(arg0: &mut vector<0x1::option::Option<u128>>, arg1: &mut vector<u128>) {
        h21ed2(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<u128>>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<0x1::option::Option<u128>>(arg0, v0);
            if (0x1::option::is_some<u128>(v1)) {
                0x1::vector::push_back<u128>(arg1, 0x1::option::extract<u128>(v1));
            };
            v0 = v0 + 1;
        };
    }

    public fun ha3a8e(arg0: &H032e6) : (vector<0x1::option::Option<u128>>, vector<0x1::option::Option<u128>>) {
        (arg0.h8f311, arg0.hd05a7)
    }

    public fun hca703(arg0: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg1: &mut H032e6, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0) == arg1.hc3725, 511);
        h68d09(arg3, arg4, arg5);
        arg1.hca48a = arg2;
        arg1.hed78c = arg3;
        arg1.hdaef6 = arg4;
        arg1.hbcb8a = arg5;
        arg1.h100f5 = arg6;
    }

    fun hcee99(arg0: &mut vector<0x1::option::Option<u128>>, arg1: u64) {
        while (0x1::vector::length<0x1::option::Option<u128>>(arg0) < arg1) {
            0x1::vector::push_back<0x1::option::Option<u128>>(arg0, 0x1::option::none<u128>());
        };
        if (0x1::vector::length<0x1::option::Option<u128>>(arg0) == arg1) {
            return
        };
        let v0 = vector[];
        let v1 = &mut v0;
        h8fd0c(arg0, v1);
        assert!(0x1::vector::length<u128>(&v0) <= arg1, 533);
        let v2 = 0x1::vector::empty<0x1::option::Option<u128>>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&v0)) {
            0x1::vector::push_back<0x1::option::Option<u128>>(&mut v2, 0x1::option::some<u128>(*0x1::vector::borrow<u128>(&v0, v3)));
            v3 = v3 + 1;
        };
        while (0x1::vector::length<0x1::option::Option<u128>>(&v2) < arg1) {
            0x1::vector::push_back<0x1::option::Option<u128>>(&mut v2, 0x1::option::none<u128>());
        };
        *arg0 = v2;
    }

    public fun hd00a6(arg0: &H032e6) : u64 {
        arg0.hd00a6
    }

    public(friend) fun hd5b68(arg0: &H032e6, arg1: bool) : u64 {
        let v0 = if (arg1) {
            &arg0.h8f311
        } else {
            &arg0.hd05a7
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::option::Option<u128>>(v0)) {
            if (0x1::option::is_none<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(v0, v2))) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun hdfd0e<T0>(arg0: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg1: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg2: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : address {
        assert!(0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0) == 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>>(arg1), 511);
        assert!(arg3 > 0, 532);
        assert!(arg4 > 0, 534);
        h68d09(arg6, arg7, arg8);
        let v0 = H032e6{
            id     : 0x2::object::new(arg10),
            hc3725 : 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>>(arg1),
            h332f0 : 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>>(arg2),
            h8f311 : h556ee(arg3),
            hd05a7 : h556ee(arg3),
            hd00a6 : arg4,
            hca48a : arg5,
            hed78c : arg6,
            hdaef6 : arg7,
            hbcb8a : arg8,
            h100f5 : arg9,
        };
        0x2::transfer::share_object<H032e6>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun hf19ba(arg0: &H032e6) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.hc3725, arg0.h332f0)
    }

    // decompiled from Move bytecode v7
}

