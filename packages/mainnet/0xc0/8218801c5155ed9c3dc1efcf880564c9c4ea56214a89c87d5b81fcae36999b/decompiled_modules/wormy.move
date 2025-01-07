module 0xc08218801c5155ed9c3dc1efcf880564c9c4ea56214a89c87d5b81fcae36999b::wormy {
    struct WORMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORMY>(arg0, 6, b"WORMY", b"Wormy", b"\"Wormy\" is the star of Wormy Survivor, an addictive pixel-art game where your main goal is to survive against a relentless onslaught of enemies. Set in a vibrant, retro-inspired world, players guide Wormy through increasingly difficult levels. As a Play-to-Earn (P2E) game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725281164441_e09634de2096709b2e91c186ec9c3239_a1480ce319.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

