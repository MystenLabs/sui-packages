module 0xf8503f1f09b6c7f13e16563781f2e5e9e301cc29bbe1d3aa0ffb2e5c5b1ed757::patton {
    struct PATTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATTON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PATTON>(arg0, 6, b"PATTON", b"Patton Trumps Dog by SuiAI", b"Patton is trumps dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2060_d7338be930.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PATTON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATTON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

