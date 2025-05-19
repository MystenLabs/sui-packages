module 0xd45ba0b3681f889840baf0d7e969740ac95d53126e0c4808a5a63cdade9fc514::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"SHUI", b"Shui on Sui", b"SHUI has arrived on SUI. Ready to conquer the chain, beware of SHUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaywdzcmshpkrfx2emys5lh4nqf64j57clokww33ljzt6agvoy4bi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

