module 0x5b21b79f0fe052f685e4eee049ded3394f71d8384278c23d60532be3f04535f::iou {
    struct Iou has store {
        sender: address,
        recipient_name_hash: vector<u8>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        expires_ms: u64,
        nonce: u64,
        sealed_memo: vector<u8>,
    }

    struct IouInitiated has copy, drop {
        storm_id: address,
        iou_key: vector<u8>,
        sender: address,
        recipient_name_hash: vector<u8>,
        amount_mist: u64,
        expires_ms: u64,
        nonce: u64,
    }

    struct IouActivated has copy, drop {
        storm_id: address,
        iou_key: vector<u8>,
        recipient: address,
        amount_mist: u64,
    }

    struct IouExpired has copy, drop {
        storm_id: address,
        iou_key: vector<u8>,
        returned_to: address,
        amount_mist: u64,
    }

    entry fun activate(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(arg0, arg1), 5);
        let Iou {
            sender              : _,
            recipient_name_hash : v1,
            balance             : v2,
            expires_ms          : v3,
            nonce               : _,
            sealed_memo         : _,
        } = 0x2::dynamic_field::remove<vector<u8>, Iou>(arg0, arg1);
        let v6 = v2;
        assert!(v1 == arg2, 0);
        assert!(0x2::clock::timestamp_ms(arg3) < v3, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4), 0x2::tx_context::sender(arg4));
        let v7 = IouActivated{
            storm_id    : 0x2::object::uid_to_address(arg0),
            iou_key     : arg1,
            recipient   : 0x2::tx_context::sender(arg4),
            amount_mist : 0x2::balance::value<0x2::sui::SUI>(&v6),
        };
        0x2::event::emit<IouActivated>(v7);
    }

    entry fun expire(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(arg0, arg1), 5);
        let Iou {
            sender              : v0,
            recipient_name_hash : _,
            balance             : v2,
            expires_ms          : v3,
            nonce               : _,
            sealed_memo         : _,
        } = 0x2::dynamic_field::remove<vector<u8>, Iou>(arg0, arg1);
        let v6 = v2;
        assert!(0x2::clock::timestamp_ms(arg2) >= v3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg3), v0);
        let v7 = IouExpired{
            storm_id    : 0x2::object::uid_to_address(arg0),
            iou_key     : arg1,
            returned_to : v0,
            amount_mist : 0x2::balance::value<0x2::sui::SUI>(&v6),
        };
        0x2::event::emit<IouExpired>(v7);
    }

    public fun has_iou(arg0: &0x2::object::UID, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(arg0, arg1)
    }

    entry fun initiate(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 4);
        let v1 = iou_key(arg1, arg2, arg5);
        let v2 = 0x2::clock::timestamp_ms(arg7) + arg4;
        let v3 = Iou{
            sender              : 0x2::tx_context::sender(arg8),
            recipient_name_hash : arg2,
            balance             : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            expires_ms          : v2,
            nonce               : arg5,
            sealed_memo         : arg6,
        };
        0x2::dynamic_field::add<vector<u8>, Iou>(arg0, v1, v3);
        let v4 = IouInitiated{
            storm_id            : 0x2::object::uid_to_address(arg0),
            iou_key             : v1,
            sender              : 0x2::tx_context::sender(arg8),
            recipient_name_hash : arg2,
            amount_mist         : v0,
            expires_ms          : v2,
            nonce               : arg5,
        };
        0x2::event::emit<IouInitiated>(v4);
    }

    public fun iou_key(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x2::hash::keccak256(&arg0)
    }

    // decompiled from Move bytecode v6
}

