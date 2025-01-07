module 0x7e7a58396d2579344bebaaaf3da0456927c2e5dcd4dcbb8755622757325d7b75::doorloseforever {
    struct DOORLOSEFOREVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOORLOSEFOREVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOORLOSEFOREVER>(arg0, 6, b"DoOrLoseForever", b"DOLF", b"\"Do Or Lose Forever\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOLF_74251cfa7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOORLOSEFOREVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOORLOSEFOREVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

