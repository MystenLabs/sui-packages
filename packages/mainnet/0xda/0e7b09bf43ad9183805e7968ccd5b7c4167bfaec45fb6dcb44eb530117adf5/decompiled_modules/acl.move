module 0xda0e7b09bf43ad9183805e7968ccd5b7c4167bfaec45fb6dcb44eb530117adf5::acl {
    struct Wulfensdjnwslma has key {
        id: 0x2::object::UID,
        coombuckets: 0x2::table::Table<0x1::ascii::String, Txirwghlfmbfiof>,
    }

    struct Txirwghlfmbfiof has store {
        coomer: address,
        zoomer: address,
        cooming: bool,
        coomtails: 0x1::option::Option<Reserve>,
        coomlet: address,
        coomcoomlet: address,
        coomsplit: u8,
    }

    struct Reserve has copy, drop, store {
        coin_coomtails: vector<ReserveDetail>,
    }

    struct ReserveDetail has copy, drop, store {
        coom_type: 0x1::ascii::String,
        coom_amount: u64,
        coom_id: 0x2::object::ID,
    }

    public entry fun aivabgtqjwoklrn<T0>(arg0: &mut Wulfensdjnwslma, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Txirwghlfmbfiof>(&arg0.coombuckets, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Txirwghlfmbfiof>(&mut arg0.coombuckets, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == v0.zoomer, 0);
        assert!(0x1::option::is_some<Reserve>(&v0.coomtails), 1);
        let v2 = 0x1::option::borrow_mut<Reserve>(&mut v0.coomtails);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = 0;
        let v5 = false;
        let v6 = 0;
        while (v4 < 0x1::vector::length<ReserveDetail>(&v2.coin_coomtails)) {
            let v7 = 0x1::vector::borrow<ReserveDetail>(&v2.coin_coomtails, v4);
            if (v7.coom_type == trim_coomer(&v3) && v7.coom_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg2)) {
                v5 = true;
                v6 = v7.coom_amount;
                break
            };
            v4 = v4 + 1;
        };
        assert!(v5, 3);
        let v8 = 0x2::coin::value<T0>(&arg2);
        assert!(v8 >= v6, 2);
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        } else if (v8 == v6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v6 * (v0.coomsplit as u64) / 100, arg3), v0.coomlet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0.coomcoomlet);
        } else {
            let v9 = 0x2::coin::split<T0>(&mut arg2, v6, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v9, v6 * (v0.coomsplit as u64) / 100, arg3), v0.coomlet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, v0.coomcoomlet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        };
        0x1::vector::swap_remove<ReserveDetail>(&mut v2.coin_coomtails, v4);
        if (0x1::vector::is_empty<ReserveDetail>(&v2.coin_coomtails)) {
            v0.coomtails = 0x1::option::none<Reserve>();
        };
    }

    public entry fun cdrcdyzrmjnqoxq(arg0: &mut Wulfensdjnwslma, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Txirwghlfmbfiof{
            coomer      : 0x2::tx_context::sender(arg6),
            zoomer      : arg2,
            cooming     : false,
            coomtails   : 0x1::option::none<Reserve>(),
            coomlet     : arg3,
            coomcoomlet : arg4,
            coomsplit   : arg5,
        };
        0x2::table::add<0x1::ascii::String, Txirwghlfmbfiof>(&mut arg0.coombuckets, arg1, v0);
    }

    public entry fun hbfzeiqmbaymdyb(arg0: &mut Wulfensdjnwslma, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: vector<0x1::ascii::String>, arg7: vector<u64>, arg8: vector<0x2::object::ID>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve{coin_coomtails: 0x1::vector::empty<ReserveDetail>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg6)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg6, v1);
            let v3 = ReserveDetail{
                coom_type   : trim_coomer(&v2),
                coom_amount : *0x1::vector::borrow<u64>(&arg7, v1),
                coom_id     : *0x1::vector::borrow<0x2::object::ID>(&arg8, v1),
            };
            0x1::vector::push_back<ReserveDetail>(&mut v0.coin_coomtails, v3);
            v1 = v1 + 1;
        };
        if (0x2::table::contains<0x1::ascii::String, Txirwghlfmbfiof>(&arg0.coombuckets, arg1)) {
            let v4 = 0x2::table::borrow_mut<0x1::ascii::String, Txirwghlfmbfiof>(&mut arg0.coombuckets, arg1);
            v4.coomer = 0x2::tx_context::sender(arg9);
            v4.zoomer = arg2;
            v4.coomlet = arg3;
            v4.coomcoomlet = arg4;
            v4.coomsplit = arg5;
            v4.cooming = false;
            v4.coomtails = 0x1::option::some<Reserve>(v0);
        } else {
            let v5 = Txirwghlfmbfiof{
                coomer      : 0x2::tx_context::sender(arg9),
                zoomer      : arg2,
                cooming     : false,
                coomtails   : 0x1::option::some<Reserve>(v0),
                coomlet     : arg3,
                coomcoomlet : arg4,
                coomsplit   : arg5,
            };
            0x2::table::add<0x1::ascii::String, Txirwghlfmbfiof>(&mut arg0.coombuckets, arg1, v5);
        };
    }

    public entry fun idbuqogvnopiimh(arg0: &mut Wulfensdjnwslma, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: u8, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<0x2::object::ID>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Txirwghlfmbfiof>(&arg0.coombuckets, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Txirwghlfmbfiof>(&mut arg0.coombuckets, arg1);
        assert!(0x2::tx_context::sender(arg8) == v0.coomer, 0);
        let v1 = Reserve{coin_coomtails: 0x1::vector::empty<ReserveDetail>()};
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&arg5)) {
            let v3 = *0x1::vector::borrow<0x1::ascii::String>(&arg5, v2);
            let v4 = ReserveDetail{
                coom_type   : trim_coomer(&v3),
                coom_amount : *0x1::vector::borrow<u64>(&arg6, v2),
                coom_id     : *0x1::vector::borrow<0x2::object::ID>(&arg7, v2),
            };
            0x1::vector::push_back<ReserveDetail>(&mut v1.coin_coomtails, v4);
            v2 = v2 + 1;
        };
        v0.coomlet = arg2;
        v0.coomcoomlet = arg3;
        v0.coomsplit = arg4;
        v0.coomtails = 0x1::option::some<Reserve>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Wulfensdjnwslma{
            id          : 0x2::object::new(arg0),
            coombuckets : 0x2::table::new<0x1::ascii::String, Txirwghlfmbfiof>(arg0),
        };
        0x2::transfer::share_object<Wulfensdjnwslma>(v0);
    }

    public entry fun ltwjfjinjlaydyb<T0: store + key>(arg0: &mut Wulfensdjnwslma, arg1: 0x1::ascii::String, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Txirwghlfmbfiof>(&arg0.coombuckets, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Txirwghlfmbfiof>(&mut arg0.coombuckets, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == v0.zoomer, 0);
        0x2::object::id<T0>(&arg2);
        if (!v0.cooming) {
            0x2::transfer::public_transfer<T0>(arg2, v1);
        } else {
            0x2::transfer::public_transfer<T0>(arg2, v0.coomcoomlet);
        };
    }

    public entry fun ndltmyojytcqwwb(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut Wulfensdjnwslma, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Txirwghlfmbfiof>(&arg2.coombuckets, arg3), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Txirwghlfmbfiof>(&mut arg2.coombuckets, arg3);
        if (v0.cooming) {
            assert!(0x1::option::is_some<Reserve>(&v0.coomtails), 1);
            let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg4), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, 0x2::coin::value<0x2::sui::SUI>(&v1) * (v0.coomsplit as u64) / 100, arg4), v0.coomlet);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0.coomcoomlet);
        } else {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg1, 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun neqwtigdopqbuwf(arg0: &mut Wulfensdjnwslma, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Txirwghlfmbfiof>(&arg0.coombuckets, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Txirwghlfmbfiof>(&mut arg0.coombuckets, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.coomer, 0);
        v0.cooming = arg2;
    }

    fun trim_coomer(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = if (v2 < 2) {
            true
        } else if (*0x1::vector::borrow<u8>(&v0, 0) != 48) {
            true
        } else {
            *0x1::vector::borrow<u8>(&v0, 1) != 120
        };
        if (v3) {
            0x1::vector::push_back<u8>(&mut v1, 48);
            0x1::vector::push_back<u8>(&mut v1, 120);
        };
        let v4 = 0;
        while (v4 < v2) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v4));
            v4 = v4 + 1;
        };
        0x1::ascii::string(v1)
    }

    // decompiled from Move bytecode v6
}

