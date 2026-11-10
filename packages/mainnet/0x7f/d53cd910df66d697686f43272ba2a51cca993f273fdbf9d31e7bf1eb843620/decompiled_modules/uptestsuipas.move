module 0x7fd53cd910df66d697686f43272ba2a51cca993f273fdbf9d31e7bf1eb843620::uptestsuipas {
    struct UPTESTSUIPAS has key {
        id: 0x2::object::UID,
    }

    struct ShareCreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_share(arg0: ShareCreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<UPTESTSUIPAS>, 0x2::coin_registry::MetadataCap<UPTESTSUIPAS>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<UPTESTSUIPAS>(arg1, 9, 0x1::string::utf8(b"UPTESTSUIPAS"), 0x1::string::utf8(b"Upshift testSUI PAS Share"), 0x1::string::utf8(b"Share of the Upshift PAS test vault for testSUI"), 0x1::string::utf8(b""), arg2);
        let ShareCreatorCap { id: v2 } = arg0;
        0x2::object::delete(v2);
        (v1, 0x2::coin_registry::finalize<UPTESTSUIPAS>(v0, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareCreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ShareCreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

