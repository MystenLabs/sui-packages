module 0xd2c5b66f4a91f320685413dc0704493453ccdad6cf62e09db367dc1978cd44cc::dogmas {
    struct DOGMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMAS>(arg0, 6, b"Dogmas", b"doggo", b"lets go buy now and let it ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DEX_LOGO_89e4c7d664.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

