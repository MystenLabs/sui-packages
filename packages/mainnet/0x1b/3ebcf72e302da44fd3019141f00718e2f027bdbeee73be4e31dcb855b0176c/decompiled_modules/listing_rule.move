module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::listing_rule {
    struct SellerProved has copy, drop {
        kiosk: 0x2::object::ID,
        owner: address,
    }

    struct ListingRule has drop {
        dummy_field: bool,
    }

    struct ListingConfig has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>) {
        let v0 = ListingRule{dummy_field: false};
        let v1 = ListingConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item, ListingRule, ListingConfig>(v0, arg0, arg1, v1);
    }

    public fun prove(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item, arg1: &mut 0x2::transfer_policy::TransferRequest<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &0x2::kiosk::Kiosk) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        prove_seller<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg1, arg3);
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0) == 0x2::transfer_policy::item<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg1), 802);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::amount(arg0) > 0, 801);
        let v0 = ListingRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item, ListingRule>(v0, arg1);
    }

    public(friend) fun prove_seller<T0>(arg0: &0x2::transfer_policy::TransferRequest<T0>, arg1: &0x2::kiosk::Kiosk) {
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == 0x2::transfer_policy::from<T0>(arg0), 803);
        let v0 = SellerProved{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            owner : 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg1),
        };
        0x2::event::emit<SellerProved>(v0);
    }

    // decompiled from Move bytecode v7
}

