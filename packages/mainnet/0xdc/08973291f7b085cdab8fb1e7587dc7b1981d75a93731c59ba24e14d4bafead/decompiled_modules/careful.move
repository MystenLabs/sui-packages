module 0xdc08973291f7b085cdab8fb1e7587dc7b1981d75a93731c59ba24e14d4bafead::careful {
    struct CAREFUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAREFUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAREFUL>(arg0, 9, b"CAREFUL", b"these new tokens are scams, be careful", b"All these new pair coins here are scams, be careful. Buy $SUIYAN or $LOFI or $REX or something else that is old instead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://indianmemetemplates.com/i-saved-you-from-cringe-again/")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAREFUL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAREFUL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAREFUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

