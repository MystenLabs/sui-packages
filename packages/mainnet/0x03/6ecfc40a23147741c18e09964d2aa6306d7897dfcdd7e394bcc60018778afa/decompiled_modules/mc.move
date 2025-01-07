module 0x36ecfc40a23147741c18e09964d2aa6306d7897dfcdd7e394bcc60018778afa::mc {
    struct MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC>(arg0, 6, b"MC", b"Moon Cat", b"MOONING SOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734370312713.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

