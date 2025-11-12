module 0x97a252b5248c0fa3cd47a78824703471a9c6798bfc2f77d55bb13f81dccef2ec::oao {
    struct OAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OAO>(arg0, 9, 0x1::string::utf8(b"OAO"), 0x1::string::utf8(b"homie"), 0x1::string::utf8(b"12"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/JwGITURlFPSPoOYTPlSoLhhs2s_k0EgDGEisrkQWwfk"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<OAO>>(0x2::coin_registry::finalize<OAO>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OAO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<OAO>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<OAO>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

