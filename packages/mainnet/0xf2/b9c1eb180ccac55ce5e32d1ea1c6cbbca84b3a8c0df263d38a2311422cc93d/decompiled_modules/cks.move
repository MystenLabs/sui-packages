module 0xf2b9c1eb180ccac55ce5e32d1ea1c6cbbca84b3a8c0df263d38a2311422cc93d::cks {
    struct CKS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CKS>, arg1: 0x2::coin::Coin<CKS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<CKS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CKS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CKS>>(0x2::coin::mint<CKS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKS>(arg0, 9, b"CKS", b"Chicken Sui", b"Winner winner! Chicken dinner!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia226pc6afuzjkdmf5bhb2bx5yoeno2qbwlfnj2zgis6utw6b47k4?filename=cks.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CKS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

