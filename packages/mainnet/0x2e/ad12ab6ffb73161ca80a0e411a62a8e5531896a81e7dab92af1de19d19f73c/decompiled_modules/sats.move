module 0x2ead12ab6ffb73161ca80a0e411a62a8e5531896a81e7dab92af1de19d19f73c::sats {
    struct SATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATS>(arg0, 9, b"Sats", b"me", b"sk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d193b5de2d4727dce44546a96d4f72fdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

