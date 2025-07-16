module 0x1462cab50fe5998f8161378e5265f7920bfd9fbce604d602619962f608837217::claim {
    struct ClaimedLedger has store, key {
        id: 0x2::object::UID,
        current_round: u8,
        claimed: 0x2::table::Table<u8, 0x2::table::Table<address, u64>>,
        balance: 0x2::balance::Balance<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>,
    }

    public entry fun claim(arg0: &mut ClaimedLedger, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 1);
        let v0 = get_message(arg0, arg1, arg2);
        let v1 = x"59337460cde859f38e6f7a98cb706d14289984a509ab6da1d08726f193cbc7ed";
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v1, &v0), 1);
        0x2::table::add<address, u64>(0x2::table::borrow_mut<u8, 0x2::table::Table<address, u64>>(&mut arg0.claimed, arg0.current_round), arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>>(0x2::coin::from_balance<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>(0x2::balance::split<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>(&mut arg0.balance, arg2), arg4), arg1);
    }

    public entry fun deposit(arg0: &mut ClaimedLedger, arg1: 0x2::coin::Coin<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>) {
        0x2::balance::join<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>(&mut arg0.balance, 0x2::coin::into_balance<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>(arg1));
    }

    public fun get_message(arg0: &ClaimedLedger, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"{\"address\":\"0x");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::address::to_string(arg1)));
        0x1::vector::append<u8>(&mut v0, b"\",\"amount\":\"");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg2)));
        0x1::vector::append<u8>(&mut v0, b"\",\"memo\":\"star\"");
        0x1::vector::append<u8>(&mut v0, b",\"round\":\"");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u8::to_string(arg0.current_round)));
        0x1::vector::append<u8>(&mut v0, b"\"}");
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xffae791c3b063c623f507d1339ba8e15796dc62f0d42765cfaa221c645a34aa4, 1);
        let v0 = ClaimedLedger{
            id            : 0x2::object::new(arg0),
            current_round : 0,
            claimed       : 0x2::table::new<u8, 0x2::table::Table<address, u64>>(arg0),
            balance       : 0x2::balance::zero<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>(),
        };
        0x2::table::add<u8, 0x2::table::Table<address, u64>>(&mut v0.claimed, 0, 0x2::table::new<address, u64>(arg0));
        0x2::transfer::public_share_object<ClaimedLedger>(v0);
    }

    public fun is_claimed(arg0: &ClaimedLedger, arg1: address) : bool {
        0x2::table::contains<address, u64>(0x2::table::borrow<u8, 0x2::table::Table<address, u64>>(&arg0.claimed, arg0.current_round), arg1)
    }

    public entry fun start_new_round(arg0: &mut ClaimedLedger, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xffae791c3b063c623f507d1339ba8e15796dc62f0d42765cfaa221c645a34aa4, 1);
        let v0 = arg0.current_round + 1;
        0x2::table::add<u8, 0x2::table::Table<address, u64>>(&mut arg0.claimed, v0, 0x2::table::new<address, u64>(arg1));
        arg0.current_round = v0;
    }

    public fun withdraw(arg0: &mut ClaimedLedger, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xffae791c3b063c623f507d1339ba8e15796dc62f0d42765cfaa221c645a34aa4, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>>(0x2::coin::from_balance<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>(0x2::balance::withdraw_all<0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars::STARS>(&mut arg0.balance), arg1), @0xffae791c3b063c623f507d1339ba8e15796dc62f0d42765cfaa221c645a34aa4);
    }

    // decompiled from Move bytecode v6
}

