module 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::marks {
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

    entry fun create_board(arg0: &0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::MarketAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
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

    entry fun mark(arg0: &mut MarkBoard, arg1: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg2: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg3: 0x2::object::ID, arg4: u8, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < 8, 3300);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 >= 1000, 3301);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg2, arg3));
        0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg1), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue::route_mark_payment(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg1), arg5, 1000, arg3, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_rank_for_index_id(arg1, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg2)), v1, arg6));
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

    entry fun mark_poi(arg0: &mut MarkBoard, arg1: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg2: &0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::proposals::ProposalBoard, arg3: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg4: u64, arg5: u8, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < 8, 3300);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v0 >= 1000, 3301);
        let v1 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::proposals::get_proposal(arg2, arg4);
        assert!(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::proposals::proposal_status(v1) == 1, 0);
        let v2 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::proposals::proposal_polygon_id(v1);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg3, v2));
        0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg1), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue::route_mark_payment(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg1), arg6, 1000, v2, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_rank_for_index_id(arg1, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg3)), v3, arg7));
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

