module 0x1986bb48d4c1a25b99fe779c1987cb9bd03c80304de6eeb8c77eac366bcc071e::teddy {
    struct TEDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEDDY>(arg0, 6, b"Teddy", b"Ilussional Creator", b"Let's do something unpredictable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736606880124.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

