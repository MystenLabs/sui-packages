module 0xa3fcf900a51ea683bee5ad8a9cda64b0a2d48a18fe716fc910fad4f7a114a7ae::exercise {
    struct NFT_EXERCISE has drop {
        dummy_field: bool,
    }

    public fun goal(arg0: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg1: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::KapyCrew, arg2: &0xbccf3732710974ca6ed41ee23e5328b9a6a63ee25ab0b1f25abeb6954a8467d1::simple_nft::SimpleNFT, arg3: &0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::Tails, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT_EXERCISE{dummy_field: false};
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::recruit(arg1, 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_pirate::new<NFT_EXERCISE>(arg0, 3, v0, arg4));
    }

    // decompiled from Move bytecode v6
}

