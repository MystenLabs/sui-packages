module 0xf4adaf8039bd9a199411709b0654f70c48bae79b026432faf653110353db57b::abcxyz {
    struct ABCXYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCXYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABCXYZ>(arg0, 6, b"ABCXYZ", b"pepe on sui", b"abcxyc is lauicnhing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731595444556.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABCXYZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCXYZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

