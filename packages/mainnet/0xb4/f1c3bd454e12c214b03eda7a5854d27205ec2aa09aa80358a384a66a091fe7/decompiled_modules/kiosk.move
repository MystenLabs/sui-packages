module 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::kiosk {
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
        0x2::transfer::public_transfer<0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::cap::AdminCap>(0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::cap::new(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KIOSK>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::Counter>(0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::new(arg1));
        0x2::transfer::public_share_object<RoyaltyConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

