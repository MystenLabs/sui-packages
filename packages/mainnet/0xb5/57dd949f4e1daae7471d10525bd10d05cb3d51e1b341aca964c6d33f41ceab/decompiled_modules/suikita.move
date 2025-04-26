module 0xb557dd949f4e1daae7471d10525bd10d05cb3d51e1b341aca964c6d33f41ceab::suikita {
    struct SUIKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKITA>(arg0, 6, b"SUIKITA", b"AKITA on SUI", b"Just a TICKER!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeietwu5t2xlhykfinnbxfjlnxe5smz4t2omjkvaqkfg2pjrgh6iily")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKITA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

