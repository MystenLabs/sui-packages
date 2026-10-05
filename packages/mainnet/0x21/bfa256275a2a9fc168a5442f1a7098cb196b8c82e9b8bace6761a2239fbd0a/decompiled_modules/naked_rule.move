module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::naked_rule {
    struct NakedRule has drop {
        dummy_field: bool,
    }

    struct NakedConfig has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>) {
        let v0 = NakedRule{dummy_field: false};
        let v1 = NakedConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, NakedRule, NakedConfig>(v0, arg0, arg1, v1);
    }

    fun assert_sellable(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) {
        assert!(!0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment::has_any_equipped(arg0), 821);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg0) >= 30, 823);
    }

    public fun prove(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &mut 0x2::transfer_policy::TransferRequest<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &0x2::kiosk::Kiosk) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::listing_rule::prove_seller<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg1, arg3);
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0) == 0x2::transfer_policy::item<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg1), 822);
        assert_sellable(arg0);
        let v0 = NakedRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, NakedRule>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

