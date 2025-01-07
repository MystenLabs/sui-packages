module 0xf685652b0409d98cb4ddd2b20637e75304fadc3a40d818042e8ce3544a6f75df::dson {
    struct DSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSON>(arg0, 6, b"DSON", b"Dimpson", b"we are ready to rule cryptia world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731010905551.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

