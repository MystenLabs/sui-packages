module 0x40e69ded27cd9172331ddee4b71acbd02624da1a4656de851ef66c4cb0655f2f::samusdc {
    struct SAMUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMUSDC>(arg0, 6, b"samUSDC", b"Sam USDC", b"Sam USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmaHxXK6Ch8TC9RVJQdbVvavUe695zSztZfGMHdWGeGFVZ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMUSDC>>(v1);
    }

    // decompiled from Move bytecode v7
}

