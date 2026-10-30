module 0x916f10ed4d592dad669e4663b59b19bcc110a62b2dd261e42a2bb83a6e9a05f9::stgusdc {
    struct STGUSDC has key {
        id: 0x2::object::UID,
    }

    struct ShareCreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_share(arg0: ShareCreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<STGUSDC>, 0x2::coin_registry::MetadataCap<STGUSDC>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<STGUSDC>(arg1, 6, 0x1::string::utf8(b"STGUSDC"), 0x1::string::utf8(b"Upshift Staging USDC"), 0x1::string::utf8(b"Upshift staging USDC vault, queued withdrawals. Not for deposits."), 0x1::string::utf8(b"https://example.com/icon.png"), arg2);
        let ShareCreatorCap { id: v2 } = arg0;
        0x2::object::delete(v2);
        (v1, 0x2::coin_registry::finalize<STGUSDC>(v0, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareCreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ShareCreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

