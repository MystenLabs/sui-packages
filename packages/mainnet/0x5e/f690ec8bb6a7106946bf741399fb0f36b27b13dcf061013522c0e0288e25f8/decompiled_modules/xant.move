module 0x5ef690ec8bb6a7106946bf741399fb0f36b27b13dcf061013522c0e0288e25f8::xant {
    struct XANT has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_currency(arg0: &AdminCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<XANT>(arg1, 9, 0x1::string::utf8(b"xANT"), 0x1::string::utf8(b"xANT"), 0x1::string::utf8(b"Fixed-supply xANT token on Sui"), 0x1::string::utf8(b"https://example.com/xant.png"), arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<XANT>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<XANT>>(0x2::coin_registry::finalize<XANT>(v3, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<XANT>>(0x2::coin::mint<XANT>(&mut v2, 10000000000000000, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

