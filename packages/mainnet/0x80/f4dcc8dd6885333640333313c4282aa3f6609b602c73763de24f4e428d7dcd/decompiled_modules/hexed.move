module 0x80f4dcc8dd6885333640333313c4282aa3f6609b602c73763de24f4e428d7dcd::hexed {
    struct HEXED has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEXED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEXED>(arg0, 6, b"HEXED", b"Hexed Land  web3 RPG", b"HexedLand is a decentralized 1-bit style open world action & social RPG on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4q_PNY_Pp0_400x400_2f069178f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEXED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEXED>>(v1);
    }

    // decompiled from Move bytecode v6
}

