module 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::marks {
    struct MarkBoard has key {
        id: 0x2::object::UID,
    }

    struct MarkKey has copy, drop, store {
        polygon_id: 0x2::object::ID,
    }

    struct MarkEvent has copy, drop {
        polygon_id: 0x2::object::ID,
        marker: address,
        owner: address,
        mark_type: u8,
        amount: u64,
    }

    struct PoiMarkKey has copy, drop, store {
        proposal_id: u64,
    }

    struct PoiMarkEvent has copy, drop {
        proposal_id: u64,
        polygon_id: 0x2::object::ID,
        marker: address,
        owner: address,
        mark_type: u8,
        amount: u64,
    }

    entry fun create_board(arg0: &0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::MarketAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarkBoard{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<MarkBoard>(v0);
    }

    public fun get_marks(arg0: &MarkBoard, arg1: 0x2::object::ID) : vector<u64> {
        let v0 = MarkKey{polygon_id: arg1};
        if (0x2::dynamic_field::exists_<MarkKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<MarkKey, vector<u64>>(&arg0.id, v0)
        } else {
            vector[0, 0, 0, 0, 0, 0, 0, 0]
        }
    }

    public fun get_poi_marks(arg0: &MarkBoard, arg1: u64) : vector<u64> {
        let v0 = PoiMarkKey{proposal_id: arg1};
        if (0x2::dynamic_field::exists_<PoiMarkKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<PoiMarkKey, vector<u64>>(&arg0.id, v0)
        } else {
            vector[0, 0, 0, 0, 0, 0, 0, 0]
        }
    }

    entry fun mark(arg0: &mut MarkBoard, arg1: &mut 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::Market, arg2: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg3: 0x2::object::ID, arg4: u8, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < 8, 3300);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 >= 1000, 3301);
        let v1 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::get(arg2, arg3));
        0x2::balance::join<0x2::sui::SUI>(0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::treasury_mut(arg1), 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::revenue::route_mark_payment(0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::market_uid_mut(arg1), arg5, 1000, arg3, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::level_rank_for_index_id(arg1, 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index>(arg2)), v1, arg6));
        let v2 = MarkKey{polygon_id: arg3};
        if (!0x2::dynamic_field::exists_<MarkKey>(&arg0.id, v2)) {
            0x2::dynamic_field::add<MarkKey, vector<u64>>(&mut arg0.id, v2, vector[0, 0, 0, 0, 0, 0, 0, 0]);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<MarkKey, vector<u64>>(&mut arg0.id, v2);
        let v4 = (arg4 as u64);
        *0x1::vector::borrow_mut<u64>(v3, v4) = *0x1::vector::borrow<u64>(v3, v4) + 1;
        let v5 = MarkEvent{
            polygon_id : arg3,
            marker     : 0x2::tx_context::sender(arg6),
            owner      : v1,
            mark_type  : arg4,
            amount     : v0,
        };
        0x2::event::emit<MarkEvent>(v5);
    }

    entry fun mark_poi(arg0: &mut MarkBoard, arg1: &mut 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::Market, arg2: &0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::proposals::ProposalBoard, arg3: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg4: u64, arg5: u8, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < 8, 3300);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v0 >= 1000, 3301);
        let v1 = 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::proposals::get_proposal(arg2, arg4);
        assert!(0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::proposals::proposal_status(v1) == 1, 0);
        let v2 = 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::proposals::proposal_polygon_id(v1);
        let v3 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::get(arg3, v2));
        0x2::balance::join<0x2::sui::SUI>(0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::treasury_mut(arg1), 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::revenue::route_mark_payment(0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::market_uid_mut(arg1), arg6, 1000, v2, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::level_rank_for_index_id(arg1, 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index>(arg3)), v3, arg7));
        let v4 = PoiMarkKey{proposal_id: arg4};
        if (!0x2::dynamic_field::exists_<PoiMarkKey>(&arg0.id, v4)) {
            0x2::dynamic_field::add<PoiMarkKey, vector<u64>>(&mut arg0.id, v4, vector[0, 0, 0, 0, 0, 0, 0, 0]);
        };
        let v5 = 0x2::dynamic_field::borrow_mut<PoiMarkKey, vector<u64>>(&mut arg0.id, v4);
        let v6 = (arg5 as u64);
        *0x1::vector::borrow_mut<u64>(v5, v6) = *0x1::vector::borrow<u64>(v5, v6) + 1;
        let v7 = PoiMarkEvent{
            proposal_id : arg4,
            polygon_id  : v2,
            marker      : 0x2::tx_context::sender(arg7),
            owner       : v3,
            mark_type   : arg5,
            amount      : v0,
        };
        0x2::event::emit<PoiMarkEvent>(v7);
    }

    // decompiled from Move bytecode v7
}

