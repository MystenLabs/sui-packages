module 0x76b36ad0e473e24b27e3809d013c48d7808ed8baceebf9a0f6d7109b047e3380::fartt {
    struct FARTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FARTT>(arg0, 6, 0x1::string::utf8(b"FartT"), 0x1::string::utf8(b"FartTest"), 0x1::string::utf8(b"farttest dev mode"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FARTT>>(0x2::coin_registry::finalize<FARTT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

