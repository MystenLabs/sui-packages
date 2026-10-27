module 0x679023f829fca72531af3beef8efd5f7914e6a4b7ab363a6cfdebb327c377028::pick {
    struct Pick has store, key {
        id: 0x2::object::UID,
        bettor: address,
        market_id: 0x1::string::String,
        cell: 0x1::string::String,
        side: u8,
        book_bps: u64,
        chain_bps: u64,
        close_bps: u64,
        outcome: u8,
        declared_size: u64,
        placed_ms: u64,
        graded_ms: u64,
    }

    struct PickPlaced has copy, drop {
        pick_id: 0x2::object::ID,
        market_id: 0x1::string::String,
        bettor: address,
        placed_ms: u64,
    }

    struct PickGraded has copy, drop {
        pick_id: 0x2::object::ID,
        close_bps: u64,
        outcome: u8,
    }

    fun copy_string(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(v0, v2));
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    public fun grade(arg0: &mut Pick, arg1: u64, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.bettor == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.outcome == 0, 1);
        assert!(arg2 == 1 || arg2 == 2, 2);
        arg0.close_bps = arg1;
        arg0.outcome = arg2;
        arg0.graded_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = PickGraded{
            pick_id   : 0x2::object::id<Pick>(arg0),
            close_bps : arg1,
            outcome   : arg2,
        };
        0x2::event::emit<PickGraded>(v0);
    }

    public fun place(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Pick {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v2 = Pick{
            id            : 0x2::object::new(arg6),
            bettor        : v0,
            market_id     : arg0,
            cell          : arg1,
            side          : arg2,
            book_bps      : arg3,
            chain_bps     : arg4,
            close_bps     : 0,
            outcome       : 0,
            declared_size : arg5,
            placed_ms     : v1,
            graded_ms     : 0,
        };
        let v3 = PickPlaced{
            pick_id   : 0x2::object::id<Pick>(&v2),
            market_id : copy_string(&arg0),
            bettor    : v0,
            placed_ms : v1,
        };
        0x2::event::emit<PickPlaced>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

