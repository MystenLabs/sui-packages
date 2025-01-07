module 0xd99de8a46f6a07654621c0283ab8dde0dc60ee206ff681e3642e0ed55091d011::tturbo {
    struct TTURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTURBO>(arg0, 6, b"Tturbo", b"Testing turbo", x"446f6ee28099742062757920616d2074657374696e672074686973", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959628074.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

