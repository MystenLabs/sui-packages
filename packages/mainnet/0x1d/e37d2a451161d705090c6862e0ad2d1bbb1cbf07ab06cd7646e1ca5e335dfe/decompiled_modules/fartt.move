module 0x1de37d2a451161d705090c6862e0ad2d1bbb1cbf07ab06cd7646e1ca5e335dfe::fartt {
    struct FARTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FARTT>(arg0, 6, 0x1::string::utf8(b"FartT"), 0x1::string::utf8(b"FartTest"), 0x1::string::utf8(b"fartpad graduation test1"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FARTT>>(0x2::coin_registry::finalize<FARTT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

