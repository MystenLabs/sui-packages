module 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::store {
    struct KioskStore has store, key {
        id: 0x2::object::UID,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v2 = KioskStore{
            id        : 0x2::object::new(arg0),
            kiosk_cap : v1,
        };
        0x2::transfer::public_share_object<KioskStore>(v2);
    }

    public(friend) fun add_item(arg0: &KioskStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0xc9bf66c933fd724a7bca680ebc6f4b833161d6d04968d99d286b80760e2a61c7::token::OloglyphicTablet) {
        0x2::kiosk::place<0xc9bf66c933fd724a7bca680ebc6f4b833161d6d04968d99d286b80760e2a61c7::token::OloglyphicTablet>(arg1, &arg0.kiosk_cap, arg2);
    }

    public(friend) fun burn_all(arg0: KioskStore) {
        let KioskStore {
            id        : v0,
            kiosk_cap : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, @0x0);
    }

    public(friend) fun remove_item(arg0: &KioskStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID) : 0xc9bf66c933fd724a7bca680ebc6f4b833161d6d04968d99d286b80760e2a61c7::token::OloglyphicTablet {
        0x2::kiosk::take<0xc9bf66c933fd724a7bca680ebc6f4b833161d6d04968d99d286b80760e2a61c7::token::OloglyphicTablet>(arg1, &arg0.kiosk_cap, arg2)
    }

    // decompiled from Move bytecode v6
}

