module 0x8585bd6edfa4c7ea70031b4631f36103c1039eb9c897cb0547ba8457eebc68f0::subgusd4 {
    struct SUBGUSD4 has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<SUBGUSD4>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<SUBGUSD4>(arg0, arg1, arg2);
    }

    fun init(arg0: SUBGUSD4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUBGUSD4>(arg0, 9, 0x1::string::utf8(b"SUBGUSD4"), 0x1::string::utf8(b"Sub Generalized USD v4"), 0x1::string::utf8(b"Sub GUSD vault token for recursive vault v4"), 0x1::string::utf8(b"https://aftermath.finance/gusd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBGUSD4>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUBGUSD4>>(0x2::coin_registry::finalize<SUBGUSD4>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

