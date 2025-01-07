module 0x3aad6532e3f917be5de897946f93892ddf2a5d7471b6a9c86013e59e96f9585a::suini {
    struct SUINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINI>(arg0, 6, b"SUINI", b"VINICIUS on SUI", b"Vinicius on SUI ($SUINI) brings pure street flow to the blockchain. With the energy of the legends and the style of those who know, $SUINI is here to shake up the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732061119230.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

