module 0xeab0e359a7160b5f59b6ca4e29650cc87b0d4e81860673cdce6cd7e9d7eff567::sheikh {
    struct SHEIKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEIKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEIKH>(arg0, 6, b"SHEIKH", b"Sheikh", b"Get Ready for Sheikh Coin Habibis!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1724684683427_5696675abaf97a158eb9251d20efa1fe_9bdbea4c2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEIKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEIKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

