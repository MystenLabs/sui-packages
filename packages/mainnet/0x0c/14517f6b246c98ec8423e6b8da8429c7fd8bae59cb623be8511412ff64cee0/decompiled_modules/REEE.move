module 0xc14517f6b246c98ec8423e6b8da8429c7fd8bae59cb623be8511412ff64cee0::REEE {
    struct REEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REEE>(arg0, 6, b"PEEPO REEE", b"REEE", b"REEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

