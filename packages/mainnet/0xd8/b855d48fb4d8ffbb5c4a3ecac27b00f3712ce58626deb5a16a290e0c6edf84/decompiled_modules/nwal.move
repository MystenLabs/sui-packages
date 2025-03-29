module 0xd8b855d48fb4d8ffbb5c4a3ecac27b00f3712ce58626deb5a16a290e0c6edf84::nwal {
    struct NWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWAL>(arg0, 9, b"nWAL", b"Sui Nigeria Walrus LST", b"nWAL is the official Walrus Liquid staking token for Sui Nigeria Community, designed to empower users with seamless staking while maintaining liquidity. By staking your WAL through nWAL you continue earning rewards while receiving a liquid token that can be used across DeFi protocols, maximizing your capital efficiency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmUL9Yuh4CByhfhvoa8mxTE931CQFvUVCvpmDTNKbppWKx")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

