module 0x72967a4fa35ab7d30d1ab1f1f94ccb9298a4200646ff5fd09200435488ee8cdc::hlw {
    struct HLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HLW>(arg0, 9, 0x1::string::utf8(b"HLW"), 0x1::string::utf8(b"homie"), 0x1::string::utf8(b"wed"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/JwGITURlFPSPoOYTPlSoLhhs2s_k0EgDGEisrkQWwfk"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HLW>>(0x2::coin_registry::finalize<HLW>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLW>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<HLW>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<HLW>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

