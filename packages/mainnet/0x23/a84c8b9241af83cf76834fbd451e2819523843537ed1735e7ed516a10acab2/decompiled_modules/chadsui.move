module 0x23a84c8b9241af83cf76834fbd451e2819523843537ed1735e7ed516a10acab2::chadsui {
    struct CHADSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADSUI>(arg0, 6, b"CHADSUI", b"GIGACHAD on SUI", b"The face is defined by a strong market, a stern expression, and stylized platform, all expertly rendered in the medium of Sui blockchain. Webs, Tg, and X are on its way. Be prepared, and join the Chad's Community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieawkieyolkboe45bggx7lj3c4vjcn4aogq2mka2phdf6blbuctwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHADSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

