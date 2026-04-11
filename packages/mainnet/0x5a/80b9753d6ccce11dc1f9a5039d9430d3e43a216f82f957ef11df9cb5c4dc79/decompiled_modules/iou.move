module 0x5a80b9753d6ccce11dc1f9a5039d9430d3e43a216f82f957ef11df9cb5c4dc79::iou {
    struct Iou has key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        expires_ms: u64,
        sealed_memo: vector<u8>,
    }

    struct IouCreated has copy, drop {
        iou_id: address,
        sender: address,
        recipient: address,
        amount_mist: u64,
        expires_ms: u64,
    }

    struct IouClaimed has copy, drop {
        iou_id: address,
        recipient: address,
        amount_mist: u64,
    }

    struct IouRecalled has copy, drop {
        iou_id: address,
        sender: address,
        amount_mist: u64,
    }

    entry fun claim(arg0: Iou, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Iou {
            id          : v0,
            sender      : _,
            recipient   : v2,
            balance     : v3,
            expires_ms  : v4,
            sealed_memo : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 0);
        assert!(0x2::clock::timestamp_ms(arg1) < v4, 3);
        0x2::object::delete(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg2), v2);
        let v8 = IouClaimed{
            iou_id      : 0x2::object::uid_to_address(&v7),
            recipient   : v2,
            amount_mist : 0x2::balance::value<0x2::sui::SUI>(&v6),
        };
        0x2::event::emit<IouClaimed>(v8);
    }

    entry fun create(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg4) + arg2;
        let v2 = Iou{
            id          : 0x2::object::new(arg5),
            sender      : 0x2::tx_context::sender(arg5),
            recipient   : arg1,
            balance     : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            expires_ms  : v1,
            sealed_memo : arg3,
        };
        let v3 = IouCreated{
            iou_id      : 0x2::object::uid_to_address(&v2.id),
            sender      : v2.sender,
            recipient   : arg1,
            amount_mist : v0,
            expires_ms  : v1,
        };
        0x2::event::emit<IouCreated>(v3);
        0x2::transfer::share_object<Iou>(v2);
    }

    entry fun recall(arg0: Iou, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Iou {
            id          : v0,
            sender      : v1,
            recipient   : _,
            balance     : v3,
            expires_ms  : v4,
            sealed_memo : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v4, 2);
        0x2::object::delete(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg2), v1);
        let v8 = IouRecalled{
            iou_id      : 0x2::object::uid_to_address(&v7),
            sender      : v1,
            amount_mist : 0x2::balance::value<0x2::sui::SUI>(&v6),
        };
        0x2::event::emit<IouRecalled>(v8);
    }

    public fun reserved_not_sender_code() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

