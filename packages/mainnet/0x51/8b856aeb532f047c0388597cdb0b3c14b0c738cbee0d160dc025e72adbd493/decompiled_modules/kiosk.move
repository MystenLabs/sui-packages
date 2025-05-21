module 0x518b856aeb532f047c0388597cdb0b3c14b0c738cbee0d160dc025e72adbd493::kiosk {
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
        0x2::transfer::public_transfer<0x518b856aeb532f047c0388597cdb0b3c14b0c738cbee0d160dc025e72adbd493::cap::AdminCap>(0x518b856aeb532f047c0388597cdb0b3c14b0c738cbee0d160dc025e72adbd493::cap::new(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KIOSK>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x518b856aeb532f047c0388597cdb0b3c14b0c738cbee0d160dc025e72adbd493::counter::Counter>(0x518b856aeb532f047c0388597cdb0b3c14b0c738cbee0d160dc025e72adbd493::counter::new(arg1));
        0x2::transfer::public_share_object<RoyaltyConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

