module 0x9f6fa596a136ae2f36324b8d8aafc24e39e01603d53a65d963d394a1a8f55451::red {
    struct RED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED>(arg0, 6, b"Red", b"Redactoor", b"Redactoor On Turbos ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731040973481.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

