module 0x7aae91fb1c5ce2ac691a00f8e2c0a423105d160a5b0f490ce3a5194792b676cd::pewnuts {
    struct PEWNUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWNUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWNUTS>(arg0, 6, b"PEWNUTS", b"PEWNUTS SUI", b"PEWNUTS PEW PEW The Squirrels", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962939925.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEWNUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWNUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

