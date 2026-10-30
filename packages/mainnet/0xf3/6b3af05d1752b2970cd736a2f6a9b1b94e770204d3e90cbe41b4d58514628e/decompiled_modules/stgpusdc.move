module 0xf36b3af05d1752b2970cd736a2f6a9b1b94e770204d3e90cbe41b4d58514628e::stgpusdc {
    struct STGPUSDC has key {
        id: 0x2::object::UID,
    }

    struct ShareCreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_share(arg0: ShareCreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<STGPUSDC>, 0x2::coin_registry::MetadataCap<STGPUSDC>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<STGPUSDC>(arg1, 6, 0x1::string::utf8(b"STGPUSDC"), 0x1::string::utf8(b"Upshift Staging PAS USDC"), 0x1::string::utf8(b"Upshift staging permissioned USDC vault. Not for deposits."), 0x1::string::utf8(b"https://example.com/icon.png"), arg2);
        let ShareCreatorCap { id: v2 } = arg0;
        0x2::object::delete(v2);
        (v1, 0x2::coin_registry::finalize<STGPUSDC>(v0, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareCreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ShareCreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

