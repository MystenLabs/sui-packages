module 0xaddb14dbe827a69b0aef263c07c0d8a77f7b1e68a5193bd52421466d64d2eb0a::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SOG", b"Sui mog coin", b"sui + mog = sog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746775463956.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

