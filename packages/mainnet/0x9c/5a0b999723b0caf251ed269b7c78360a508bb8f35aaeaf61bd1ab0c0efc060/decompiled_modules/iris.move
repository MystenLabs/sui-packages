module 0x9c5a0b999723b0caf251ed269b7c78360a508bb8f35aaeaf61bd1ab0c0efc060::iris {
    struct IRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRIS>(arg0, 6, b"IRIS", b"IRIS AI", b"Interactive Recursive Imagination System Gallery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733302331379.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

