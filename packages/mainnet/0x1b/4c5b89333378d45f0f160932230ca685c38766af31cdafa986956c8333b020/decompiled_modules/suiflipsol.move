module 0x1b4c5b89333378d45f0f160932230ca685c38766af31cdafa986956c8333b020::suiflipsol {
    struct SUIFLIPSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLIPSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLIPSOL>(arg0, 6, b"SuiFlipSol", b"Sui Flip Sol", b"A memecoin for believers in Sui overtaking Solana. Combining humor with the competitive spirit of blockchain, SuiFlipSol represents the playful rivalry between two major networks as Sui aims to \"flip\" Solana in market dominance. Join the fun and be part of the flip!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000105430_db10364cbc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLIPSOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFLIPSOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

