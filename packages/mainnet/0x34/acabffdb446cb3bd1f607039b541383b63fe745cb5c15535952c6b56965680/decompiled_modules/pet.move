module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::pet {
    struct FeedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeedState has copy, drop, store {
        count: u64,
        last_day: u64,
    }

    struct PetFed has copy, drop {
        pet: 0x2::object::ID,
        feeder: address,
        power: u64,
    }

    fun feed(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::category(arg0) == 0x1::string::utf8(b"pet"), 2501);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::uid_mut(arg0);
        let v2 = FeedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FeedKey>(v1, v2)) {
            let v3 = FeedKey{dummy_field: false};
            let v4 = FeedState{
                count    : 0,
                last_day : 0,
            };
            0x2::dynamic_field::add<FeedKey, FeedState>(v1, v3, v4);
        };
        let v5 = FeedKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<FeedKey, FeedState>(v1, v5);
        assert!(v6.count < 60, 2504);
        assert!(v0 > v6.last_day, 2503);
        v6.count = v6.count + 1;
        v6.last_day = v0;
        let v7 = PetFed{
            pet    : 0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0),
            feeder : 0x2::tx_context::sender(arg2),
            power  : v6.count,
        };
        0x2::event::emit<PetFed>(v7);
    }

    public(friend) fun feed_kiosk_pet(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::template(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0, arg1, arg4)) == 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg2), 2505);
        let v0 = 0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0, arg1, arg5);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::item_type(v0);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::category(v0) == 0x1::string::utf8(b"resource"), 2502);
        let v2 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::pet_foods(arg2);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::pet_accepts(&v2, &v1), 2502);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::burn(arg0, arg1, arg3, arg5, 1, arg7);
        let v3 = 0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0, arg1, arg4);
        feed(v3, arg6, arg7);
    }

    public fun power(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item) : u64 {
        let v0 = FeedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FeedKey>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::uid(arg0), v0)) {
            return 0
        };
        let v1 = FeedKey{dummy_field: false};
        0x2::dynamic_field::borrow<FeedKey, FeedState>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::uid(arg0), v1).count
    }

    public fun scaled_stats(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics {
        if (!0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::has_stats(arg0)) {
            return 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::zero()
        };
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::stats(arg0);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::scale_from_center(&v0, power(arg0), 60)
    }

    // decompiled from Move bytecode v7
}

