module 0xb1c4b16ad62cf7275278fa04cabc98683caad04daf025ad3c0a637b8ac9d8a0b::babypugwif {
    struct BABYPUGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPUGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPUGWIF>(arg0, 6, b"Babypugwif", b"bebypugwif", b"Pugwif Network is a decentralized leveraged trading platform. The platform provides users with a variety of trading assets, including cryptocurrencies and stocks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736934911533.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPUGWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPUGWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

