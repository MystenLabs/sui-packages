module 0x7c3a11d86e55eb1487e821517f1ab91f81bb3ab5db63acceec2a25c78c263bd9::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 9, b"SAI", b"Satoshi AI", b"SATOSHI AI AGENTS  the ultimate grind to carve your own future, fam. Let's get this crypto bag! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbNRLc2G9UKPFYEMBr4euSTzdjBiRyfYFGXLgHwoxoUG2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

