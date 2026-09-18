module 0x37906c25c3c4e8230db7ce244a7fce7dc2daf3553592074458a28f71c25b386::rise {
    struct RISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISE>(arg0, 6, b"Rise", b"Suirez", x"4d656d657320646f6ee2809974206469652e20546865792052495345206f6e2053756921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789756393041.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RISE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

