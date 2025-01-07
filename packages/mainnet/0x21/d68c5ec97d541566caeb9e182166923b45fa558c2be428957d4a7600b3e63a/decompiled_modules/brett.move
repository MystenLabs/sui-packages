module 0x21d68c5ec97d541566caeb9e182166923b45fa558c2be428957d4a7600b3e63a::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"Based Sharon", b"$SHARE Based Sharon , $BRETT s ONLY girlfriend on base and the crypto with a big heart. Partnered with YouTube powerhouse @StevenSchapiro, their goal is to grow wealth and spread kindness at the same time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725641694462_9a52b8dcd61e572df79cd23ce35f6c9e_af16085286.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

