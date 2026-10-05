module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::lot_rule {
    struct LotRule has drop {
        dummy_field: bool,
    }

    struct LotConfig has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>) {
        let v0 = LotRule{dummy_field: false};
        let v1 = LotConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item, LotRule, LotConfig>(v0, arg0, arg1, v1);
    }

    public fun prove(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item, arg1: &mut 0x2::transfer_policy::TransferRequest<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0) == 0x2::transfer_policy::item<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg1), 702);
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::category(arg0);
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&v0)) {
            assert!(valid_lot(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::amount(arg0), 0x2::transfer_policy::paid<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg1)), 701);
        };
        let v1 = LotRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item, LotRule>(v1, arg1);
    }

    fun valid_lot(arg0: u32, arg1: u64) : bool {
        if (arg1 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 10) {
            true
        } else if (arg0 == 100) {
            true
        } else {
            arg0 == 1000
        }
    }

    // decompiled from Move bytecode v7
}

