module 0xc367e535f7133d87da5647b552604eefb0c3a95106178e874964fec41d0ae87b::stgsui {
    struct STGSUI has key {
        id: 0x2::object::UID,
    }

    struct ShareCreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_share(arg0: ShareCreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<STGSUI>, 0x2::coin_registry::MetadataCap<STGSUI>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<STGSUI>(arg1, 9, 0x1::string::utf8(b"STGSUI"), 0x1::string::utf8(b"Upshift Staging SUI"), 0x1::string::utf8(b"Upshift staging SUI vault, instant redemption. Not for deposits."), 0x1::string::utf8(b"https://example.com/icon.png"), arg2);
        let ShareCreatorCap { id: v2 } = arg0;
        0x2::object::delete(v2);
        (v1, 0x2::coin_registry::finalize<STGSUI>(v0, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareCreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ShareCreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

