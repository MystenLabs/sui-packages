module 0xe40ec96a71e626944785e2aa3fb07c87da692d2927ac61a5cabf04f7af7889f4::groklet {
    struct GROKLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROKLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROKLET>(arg0, 6, b"GROKLET", b"GROKLET SUI", b"A new era in sui has begun. let's support $GROKLETSUI until it reaches cetus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibw7wkib6tb452pagjw7zgcnvxrjfzcsajnmcrdrr5yvpmevtzjje")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROKLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GROKLET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

