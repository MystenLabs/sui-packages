module 0x5aa3223ad08d6279c067ce01290e52d1b32a5d53d34c6fd7b195af5ce84176ed::novi_escrow {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EscrowObject has store, key {
        id: 0x2::object::UID,
        trade_id: u64,
        seller: address,
        buyer: address,
        platform: address,
        locked_coin: 0x2::coin::Coin<0x2::sui::SUI>,
        fee_bps: u64,
        funded_at_ms: u64,
        status: u8,
    }

    struct EscrowFunded has copy, drop {
        trade_id: u64,
        seller: address,
        buyer: address,
        amount: u64,
    }

    struct EscrowReleased has copy, drop {
        trade_id: u64,
        net: u64,
        fee: u64,
    }

    struct EscrowRefunded has copy, drop {
        trade_id: u64,
        amount: u64,
    }

    struct EscrowDisputed has copy, drop {
        trade_id: u64,
        by: address,
    }

    struct EscrowResolved has copy, drop {
        trade_id: u64,
        to_buyer: bool,
    }

    public entry fun dispute_escrow(arg0: &mut EscrowObject, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 4);
        arg0.status = 3;
        let v1 = EscrowDisputed{
            trade_id : arg0.trade_id,
            by       : v0,
        };
        0x2::event::emit<EscrowDisputed>(v1);
    }

    public entry fun fund_escrow(arg0: u64, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 6);
        assert!(arg5 >= 125 && arg5 <= 500, 7);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = EscrowObject{
            id           : 0x2::object::new(arg6),
            trade_id     : arg0,
            seller       : v1,
            buyer        : arg1,
            platform     : arg2,
            locked_coin  : arg3,
            fee_bps      : arg5,
            funded_at_ms : 0x2::clock::timestamp_ms(arg4),
            status       : 0,
        };
        let v3 = EscrowFunded{
            trade_id : arg0,
            seller   : v1,
            buyer    : arg1,
            amount   : v0,
        };
        0x2::event::emit<EscrowFunded>(v3);
        0x2::transfer::share_object<EscrowObject>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun refund_to_seller(arg0: &mut EscrowObject, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.buyer || 0x2::clock::timestamp_ms(arg1) >= arg0.funded_at_ms + 604800000, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0.locked_coin);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.locked_coin, v0, arg2), arg0.seller);
        arg0.status = 2;
        let v1 = EscrowRefunded{
            trade_id : arg0.trade_id,
            amount   : v0,
        };
        0x2::event::emit<EscrowRefunded>(v1);
    }

    public entry fun release_to_buyer(arg0: &mut EscrowObject, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0.locked_coin);
        let v1 = v0 * arg0.fee_bps / 10000;
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.locked_coin, v2, arg1), arg0.buyer);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.locked_coin, v1, arg1), arg0.platform);
        arg0.status = 1;
        let v3 = EscrowReleased{
            trade_id : arg0.trade_id,
            net      : v2,
            fee      : v1,
        };
        0x2::event::emit<EscrowReleased>(v3);
    }

    public entry fun resolve_dispute(arg0: &mut EscrowObject, arg1: bool, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0.locked_coin);
        if (arg1) {
            let v1 = v0 * arg0.fee_bps / 10000;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.locked_coin, v0 - v1, arg3), arg0.buyer);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.locked_coin, v1, arg3), arg0.platform);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.locked_coin, v0, arg3), arg0.seller);
        };
        arg0.status = 4;
        let v2 = EscrowResolved{
            trade_id : arg0.trade_id,
            to_buyer : arg1,
        };
        0x2::event::emit<EscrowResolved>(v2);
    }

    // decompiled from Move bytecode v7
}

