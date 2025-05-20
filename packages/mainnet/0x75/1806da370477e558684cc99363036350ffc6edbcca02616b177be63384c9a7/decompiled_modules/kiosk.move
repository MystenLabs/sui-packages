module 0x751806da370477e558684cc99363036350ffc6edbcca02616b177be63384c9a7::kiosk {
    struct KIOSK has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has store, key {
        id: 0x2::object::UID,
        royalty_wallet: address,
    }

    public fun get_royalty_wallet(arg0: &RoyaltyConfig) : address {
        arg0.royalty_wallet
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyConfig{
            id             : 0x2::object::new(arg1),
            royalty_wallet : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<0x751806da370477e558684cc99363036350ffc6edbcca02616b177be63384c9a7::cap::AdminCap>(0x751806da370477e558684cc99363036350ffc6edbcca02616b177be63384c9a7::cap::new(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KIOSK>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x751806da370477e558684cc99363036350ffc6edbcca02616b177be63384c9a7::counter::Counter>(0x751806da370477e558684cc99363036350ffc6edbcca02616b177be63384c9a7::counter::new(arg1));
        0x2::transfer::public_share_object<RoyaltyConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

