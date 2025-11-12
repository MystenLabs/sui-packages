module 0x9a64a617cfb966f1aaaf43162a027a134d81ca7f094eca68979c6965423a18da::vt {
    struct VT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VT>(arg0, 9, 0x1::string::utf8(b"VT"), 0x1::string::utf8(b"healthyfood"), 0x1::string::utf8(b"12"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/JwGITURlFPSPoOYTPlSoLhhs2s_k0EgDGEisrkQWwfk"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VT>>(0x2::coin_registry::finalize<VT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<VT>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<VT>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

