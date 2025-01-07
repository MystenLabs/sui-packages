module 0x4744e3832cc3eff02d86d568288bb177e9bff057ab2749bd7f1d7e3136d563cb::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HONEY>(arg0, 6859021940350650818, b"Honey the lab", b"$Honey", b"Honey is a Youtube creator and a dog by nature!", b"https://images.hop.ag/ipfs/QmWFDZL5cx1XYM7QAdNYx7k5VahVXRMNQ86bFKMm1LTt9T", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/honeytheogdog"), arg1);
    }

    // decompiled from Move bytecode v6
}

